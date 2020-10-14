import RxCocoa
import RxSwift
import UIKit

// MARK: Class

public class GPValueDisplayView: UIView {
    
    // MARK: - Private Variables

    public let inputMode: InputValueViewMode
    public var rx_value = BehaviorRelay<Double>(value: 0)
    public var rx_textValue: BehaviorRelay<String?>

    public lazy var currency: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "R$"
        label.textColor = GPColors.heyman.color
        label.font = FontFamily.Calibri.regular.font(size: 32)
        label.isHidden = self.inputMode == .CV ? true : false
        return label
    }()

    public lazy var valueLabel: UILabel = {
        let text = UILabel(frame: .zero)
        text.text = self.inputMode == .CV ? "00" : "0,00"
        text.adjustsFontSizeToFitWidth = true
        text.minimumScaleFactor = 0.7
        text.adjustsFontForContentSizeCategory = true
        text.font = FontFamily.Calibri.bold.font(size: 60.0)
        text.textColor = GPColors.barney.color
        return text
    }()

    // MARK: Initializers

    public init(mode: InputValueViewMode) {
        inputMode = mode
        if mode == .CV {
            rx_textValue = BehaviorRelay(value: "00")
        } else {
            rx_textValue = BehaviorRelay(value: 0.0.formatedAsCurrency)
        }

        super.init(frame: .zero)

        addComponents()
        setupConstraints()
        uptateTextValue()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal Methods

    func update(value valueString: String) {
        if let intValue = Int(valueString) {
            addRightNumber(number: intValue)
        } else if valueString == "C" {
            clear()
        } else {
            backspace()
        }
    }

    // MARK: Private Methods

    private func clear() {
        rx_value.accept(0)
        uptateTextValue()
    }

    private func backspace() {
        let numberString: String
        if inputMode == .CV {
            let valueString = String(Int(rx_value.value))
            numberString = String(valueString.dropLast())
            rx_value.accept(Double(Int(numberString) ?? 0))
            uptateTextValue()
        } else {
            numberString = String(format: "%.2f", rx_value.value)
            guard let lastNumber = numberString.last else { return }
            let numberToRemoveAsString = "0.0\(lastNumber)"
            guard let numberToRemove = Double(numberToRemoveAsString) else { return }
            rx_value.accept(rx_value.value - numberToRemove)
            rx_value.accept(rx_value.value / 10)
            rx_value.accept(abs(rx_value.value))
            uptateTextValue()
        }
    }

    private func addRightNumber(number: Int) {
        if inputMode == .CV {
            let newNumberString: String
            if rx_value.value == 0 {
                newNumberString = "\(number)"
            } else {
                newNumberString = "\(Int(rx_value.value))\(number)"
            }
            guard let tempValue = Double(newNumberString) else { return }
            if newNumberString.count <= 11 {
                rx_value.accept(tempValue)
                uptateTextValue()
            }
        } else {
            let newNumberString = "0.0\(number)"
            guard let newNumber = Double(newNumberString) else { return }
            var tempValue = rx_value.value
            tempValue *= 10
            tempValue += newNumber
            if String(format: "%.2f", tempValue).count <= 11 {
                rx_value.accept(tempValue)
                uptateTextValue()
            }
        }
    }

    private func addComponents() {
        addSubviews([currency,
                     valueLabel], constraints: true)
    }

    private func setupConstraints() {
        currency.centerYAnchor.constraint(equalTo: valueLabel.centerYAnchor, constant: 1).isActive = true
        var trailingConstant: CGFloat = 0.0
        if #available(iOS 13.0, *) {
            trailingConstant = 6.0
        } else if #available(iOS 11.0, *) {
            trailingConstant = -6.0
        }
        currency.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: trailingConstant).isActive = true

        valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 6).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10).isActive = true
        valueLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85).isActive = true
        let valueWidth = valueLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.8)
        valueWidth.isActive = true
    }

    private func uptateTextValue() {
        switch inputMode {
        case .CV:
            rx_textValue.accept("\(Int(rx_value.value))")
            valueLabel.text = "\(Int(rx_value.value))"
        default:
            rx_textValue.accept(rx_value.value.formatedAsCurrency)
            valueLabel.text = rx_value.value.formatedAsCurrency.replacingOccurrences(of: "R$", with: "")
        }
    }
}
