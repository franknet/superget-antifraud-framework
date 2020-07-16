import RxSwift
import UIKit

public class SellButtonView: UIView {
    
    // MARK: - Public Variables

    public let btn = GPButton(title: "CONTINUAR", style: .filled)

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        addComponents()
        setupComponents()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func addComponents() {
        addSubview(btn, constraints: true)
    }

    private func setupComponents() {
        btn.isEnabled = false
        btn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        btn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        btn.applyAnchors(ofType: [.top, .bottom], to: self)
    }
}
