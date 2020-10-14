import UIKit
import RxCocoa
import RxSwift

public class GPStackButton: GPRoundedButton {
    
    // MARK: - Private Properties

    private var dBag = DisposeBag()
    private let notificationCenter = NotificationCenter.default
    private var title: String = ""

    // MARK: Initializers

    init(title: String? = nil, image: UIImage? = nil, bgColor: UIColor) {
        super.init(frame: .zero)
        self.title = title ?? ""
        if image != nil {
            setImage(image, for: .normal)
        } else {
            setTitle(title, for: .normal)
            setTitleColor(.black, for: .normal)
        }
        titleLabel?.font = FontFamily.Calibri.regular.font(size: 30)
        backgroundImageColor = bgColor
        cornerRadius = 10

        setupBind()
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setupBind() {
        rx.tap.bind { [weak self] in
            guard let self = self else { return }
            self.notificationCenter.post(name: .sellInputValue,
                                         object: nil,
                                         userInfo: ["value": self.title])
        }.disposed(by: dBag)
    }
}

class GPStackLine: UIStackView {
    init(buttons: [UIButton]) {
        super.init(frame: .zero)
        axis = .horizontal
        distribution = .fillEqually
        spacing = 6
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        for button in buttons {
            addArrangedSubview(button)
        }
    }

    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol GPCalculatorStackDelegate: AnyObject {
    func didPress() -> Int
}

class GPCalculatorStack: UIStackView {
    
    // MARK: - Private Variables

    private let buttonColor = GPColors.moe.color

    private var inputMode: InputValueViewMode

    private lazy var stack1: GPStackLine = {
        let line = GPStackLine(buttons: [GPStackButton(title: "1", bgColor: buttonColor),
                                         GPStackButton(title: "2", bgColor: buttonColor),
                                         GPStackButton(title: "3", bgColor: buttonColor)])
        return line
    }()

    private lazy var stack2: GPStackLine = {
        let line = GPStackLine(buttons: [GPStackButton(title: "4", bgColor: buttonColor),
                                         GPStackButton(title: "5", bgColor: buttonColor),
                                         GPStackButton(title: "6", bgColor: buttonColor)])
        return line
    }()

    private lazy var stack3: GPStackLine = {
        let line = GPStackLine(buttons: [GPStackButton(title: "7", bgColor: buttonColor),
                                         GPStackButton(title: "8", bgColor: buttonColor),
                                         GPStackButton(title: "9", bgColor: buttonColor)])
        return line
    }()

    private lazy var stack4: GPStackLine = {
        let btnImage = GPStackButton(image: GPAssets.gnBackspace.image,
                                     bgColor: GPColors.maggie.color)
        btnImage.tintColor = GPColors.barney.color
        
        let line = GPStackLine(buttons: [GPStackButton(title: "C", bgColor: GPColors.maggie.color),
                                         GPStackButton(title: "0", bgColor: buttonColor),
                                         btnImage])
        return line
    }()

    // MARK: - Public variables

    public weak var delegate: GPCalculatorStackDelegate?

    // MARK: - Initializers

    init(mode: InputValueViewMode) {
        inputMode = mode
        super.init(frame: .zero)

        setupLayout()
        addComponents()
    }

    override init(frame: CGRect) {
        inputMode = .sell
        super.init(frame: frame)
        setupLayout()
        addComponents()
    }

    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func addComponents() {
        addArrangedSubview(stack1)
        addArrangedSubview(stack2)
        addArrangedSubview(stack3)
        addArrangedSubview(stack4)
    }

    private func setupLayout() {
        axis = .vertical
        spacing = 6
        distribution = .fillEqually
    }
}
