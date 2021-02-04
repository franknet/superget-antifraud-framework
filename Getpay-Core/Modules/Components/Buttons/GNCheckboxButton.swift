import UIKit

// MARK: - Class

final public class GNCheckboxButton: UIButton {
    
    // MARK: - Private variables
    
    private let checked = GPAssets.gpCheckboxSelected.image
    
    private let unchecked = GPAssets.gpCheckbox.image
    
    // MARK: - Public variables
    
    public var isChecked: Bool = false {
        didSet {
            isChecked ? self.setImage(checked, for: .normal) : self.setImage(unchecked, for: .normal)
        }
    }
    
    // MARK: - Initializers
    
    public init() {
        super.init(frame: .zero)
        self.common()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GNCheckboxButton {
    
    // MARK: - Private methods
    
    private func common() {
        self.height(size: 24.0)
        self.width(size: 24.0)
        self.setImage(unchecked, for: .normal)
        self.addTarget(self,
                       action:#selector(buttonClicked(sender:)),
                       for: .touchUpInside)
    }
    
    @objc private func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked.toggle()
        }
    }
}
