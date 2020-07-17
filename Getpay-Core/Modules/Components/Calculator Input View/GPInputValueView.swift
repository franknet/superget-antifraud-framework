import UIKit
import RxSwift

// MARK: Input Value View Mode

public enum InputValueViewMode {
    case sell
    case reverse
    case CV
    case none
    case transaction
}

// MARK: - Class

public class GPInputValueView: UIView {
    // MARK: Public Variables

    // MARK: Private Variables

    private var dBag = DisposeBag()
    private var inputMode: InputValueViewMode

    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        stack.distribution = .fillProportionally
        return stack
    }()

    private lazy var calculator: GPCalculatorStack = {
        let input = GPCalculatorStack(mode: self.inputMode)
        return input
    }()

    public lazy var valueDisplay: GPValueDisplayView = {
        let value = GPValueDisplayView(mode: self.inputMode)
        return value
    }()

    // MARK: internal Variables

    public lazy var sellButton: SellButtonView = {
        let btn = SellButtonView()
        return btn
    }()

    // MARK: Initializers

    public init(mode: InputValueViewMode) {
        inputMode = mode
        super.init(frame: .zero)

        addComponents()
        setupConstraints()
        setupNotifications()
        setupPayButton(withValue: 0)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func addComponents() {
        addSubview(stack, constraints: true)
        stack.addArrangedSubview(valueDisplay)
        stack.addArrangedSubview(calculator)
        stack.addArrangedSubview(sellButton)

        valueDisplay.rx_textValue.asObservable().bind { [weak self] stringValue in
            GPLogger.log(stringValue ?? "")
            if let numbers = stringValue?.westernArabicNumeralsOnly {
                if let floatValue = Float(numbers) {
                    self?.setupPayButton(withValue: floatValue)
                }
            }
        }.disposed(by: dBag)
    }

    private func setupConstraints() {
        stack.applyAnchors(ofType: [.top, .bottom, .leading, .trailing], to: self)
        sellButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        calculator.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.5).isActive = true
//        valueDisplay.heightAnchor.constraint(lessThanOrEqualTo: calculator.heightAnchor, multiplier: 0.4).isActive = true
    }

    private func setupNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateValue(notification:)),
                                               name: .sellInputValue,
                                               object: nil)
    }

    @objc private func updateValue(notification: Notification) {
        if let userInfo = notification.userInfo {
            if let value = userInfo["value"] as? String {
                valueDisplay.update(value: value)
            }
        }
    }

    // legacy function
    private func setupPayButton(withValue value: Float) {
        if value > 0 {
            sellButton.btn.isEnabled = true
        } else {
            sellButton.btn.isEnabled = false
        }
    }

    // MARK: Public Methods

    public func clear() {
        valueDisplay.update(value: "C")
    }
}
