import RxCocoa
import RxSwift
import UIKit

// MARK: - Class

public class SwitchButton: UIButton {
    
    // MARK: - Private Variables

    private let enabledColor: UIColor = {
        let color = GPColors.homer.color
        return color
    }()

    private let disabledColor: UIColor = {
        let color = GPColors.krusty.color
        return color
    }()

    // MARK: - Initializers

    public init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(enabledColor, for: .selected)
        titleLabel?.font = FontFamily.Calibri.regular.font(size: 16)
        setTitleColor(disabledColor, for: .normal)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: - Private Methods

    private func setupComponents() {
        heightAnchor.constraint(lessThanOrEqualToConstant: 48).isActive = true
    }
}
