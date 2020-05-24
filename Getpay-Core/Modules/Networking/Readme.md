Usage examples

```
class Service {
    init() {}

    func getExample() -> Observable<ExampleResponse> {
        let service = ServiceManager()
        let request = ExampleRequest()
        return service.performRequest(route: request)
    }

    func getExample(completion: @escaping (Result<ExampleResponse, Error>) -> Void) {
        let service = ServiceManager()
        let request = ExampleRequest()
        service.performRequest(route: request, completion: completion)
    }

    func getExampleWithNoResponse(completion: @escaping (Error?) -> Void) {
        let service = ServiceManager()
        let request = ExampleRequest()
        service.performRequest(route: request, completion: completion)
    }
}

// MARK: Request

struct ExampleRequest: BaseRequestProtocol {
    var method: GPHttpMethod
    var path: String
    var body: Parameters
    init() {
        method = .get
        path = baseURL + "/api/v1/example"
        body = nil
    }
}

// MARK: Response

struct ExampleResponse: Decodable {
    let content: [String]
}

Usage example in ViewModel

func getExample() -> Observable<ExampleResponse> {
    return Service().getExample()
        .asObservable()
        .catchError{ [weak self] _ in
            return Observable.empty()
        }
        .do(onNext: { [weak self] results in
            self?.dataSource = results.content
    })
}

func getExample(completion: @escaping (ExampleResponse) -> Void) {
    Service().getExample { [weak self] response in
        switch response {
        case let .success(data):
            self?.dataSource = data.content
            completion(data)
        case .failure(_):
            self?.state.accept(.error)
        }
    }
}

in ViewController...

Using Rx version
let result = viewModel.getExample()

result
    .observeOn(MainScheduler.instance)
    .subscribe(onNext: { [weak self] _ in
        guard let self = self else { return }
        self.customView.tableView.reloadData()
    }).disposed(by: disposeBag)

Using Completion version
_ = viewModel.getExample { [weak self] _ in
    self?.customView.tableView.reloadData()
}

```
