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
    // MARK: Private Variables

    private enum Colors {
        static let buttonSale = GPColors.moe.color
        static let buttonReverse = UIColor.white
        static let backgroundSale = GPColors.apu.color
        static let backgroundReverse = GPColors.moe.color
    }

    private var inputMode: InputValueViewMode

    private lazy var stack1: GPStackLine = {
        let buttonColor = getButtonColor(forMode: self.inputMode)
        let line = GPStackLine(buttons: [
            GPStackButton(title: "1", bgColor: buttonColor),
            GPStackButton(title: "2", bgColor: buttonColor),
            GPStackButton(title: "3", bgColor: buttonColor)
        ])
        return line
    }()

    private lazy var stack2: GPStackLine = {
        let buttonColor = getButtonColor(forMode: self.inputMode)
        let line = GPStackLine(buttons: [
            GPStackButton(title: "4", bgColor: buttonColor),
            GPStackButton(title: "5", bgColor: buttonColor),
            GPStackButton(title: "6", bgColor: buttonColor)
        ])
        return line
    }()

    private lazy var stack3: GPStackLine = {
        let buttonColor = getButtonColor(forMode: self.inputMode)
        let line = GPStackLine(buttons: [
            GPStackButton(title: "7", bgColor: buttonColor),
            GPStackButton(title: "8", bgColor: buttonColor),
            GPStackButton(title: "9", bgColor: buttonColor)
        ])
        return line
    }()

    private lazy var stack4: GPStackLine = {
        let buttonColor = getButtonColor(forMode: self.inputMode)
        let customButtonColor = getCustomButtonColor(forMode: self.inputMode)
        let specialButtonColor = getCustomBackSpaceAndClearButton(forMode: self.inputMode)
        let btnImage = GPStackButton(image: UIImage(named: "gn_backspace"), bgColor: specialButtonColor)
        btnImage.tintColor = .black
        let line = GPStackLine(buttons: [
            GPStackButton(title: "C", bgColor: specialButtonColor),
            GPStackButton(title: "0", bgColor: buttonColor),
            btnImage
        ])
        return line
    }()

    // MARK: Public Variable

    public weak var delegate: GPCalculatorStackDelegate?

    // MARK: Initializers

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

    private func getButtonColor(forMode _: InputValueViewMode) -> UIColor {
        switch inputMode {
        case .sell, .transaction:
            return Colors.buttonSale
        default:
            return Colors.buttonReverse
        }
    }

    private func getCustomButtonColor(forMode _: InputValueViewMode) -> UIColor {
        return inputMode == .sell ? Colors.backgroundSale : Colors.backgroundReverse
    }
    
    private func getCustomBackSpaceAndClearButton(forMode _: InputValueViewMode) -> UIColor {
        switch inputMode {
        case .sell:
            return Colors.backgroundSale
        case .transaction:
            return GPColors.maggie.color
        default:
            return Colors.backgroundReverse
        }
    }
}
