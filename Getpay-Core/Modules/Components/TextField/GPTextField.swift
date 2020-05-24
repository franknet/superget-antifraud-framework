import Foundation
import RxSwift
import UIKit
import JVFloatLabeledTextField
import RxGesture

public enum MaskType: Int {
    case mobilePhone, cpf, cnpj
}

final public class GPCustomTextField: JVFloatLabeledTextField {
    public let disposeBag = DisposeBag()

    public var maskType: MaskType?

    public init(label: String, type: UIKeyboardType? = .default, maskType: MaskType? = nil) {
        super.init(frame: .zero)

        borderStyle = .roundedRect
        floatingLabelActiveTextColor = GPColors.homer.color
        floatingLabelTextColor = GPColors.homer.color
        floatingLabelYPadding = 5
        autocapitalizationType = .none
        floatingLabelYPadding = 5
        placeholder = label

        if let type = type {
            keyboardType = type
        }

        if let maskType = maskType {
            self.maskType = maskType
        }

        setupRX()
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GPCustomTextField {
    public func setupRX() {
        rx.controlEvent([.editingDidBegin])
            .asObservable()
            .subscribe(onNext: { _ in
                self.layer.borderColor = GPColors.homer.color.cgColor
                self.layer.borderWidth = 1.0
                self.borderStyle = .roundedRect
                self.layer.cornerRadius = 3
            })
            .disposed(by: disposeBag)

        rx.controlEvent([.editingChanged])
            .asObservable()
            .subscribe(onNext: { _ in
                if let maskType = self.maskType {
                    self.text = self.applyMask(maskType)
                }
            })
            .disposed(by: disposeBag)

        rx.controlEvent([.editingDidEnd])
            .asObservable()
            .subscribe(onNext: { _ in
                self.layer.borderColor = GPColors.krusty.color.cgColor
                self.layer.borderWidth = 0.0
                self.layer.cornerRadius = 3
            })
            .disposed(by: disposeBag)
    }

    public func applyMask(_: MaskType) -> String {
        guard
            let text = self.text,
            let maskType = self.maskType
            else { return "" }

        switch maskType {
        case .cpf:
            return text.formatedAsCPF
        case .cnpj:
            return text.formatedAsCNPJ
        case .mobilePhone:
            return text.formatedPhone
        }
    }
}
