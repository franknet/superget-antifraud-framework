import UIKit

// MARK: - Class

public class GNRadiusButton: UIButton {
    
    // MARK: - Private variables
    
    private let checked = GPAssets.gpRadioSelected.image
    
    private let unchecked = GPAssets.gpRadio.image
    
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
    
    // MARK: - Internal methods
    
    func common() {
        self.height(size: 20.0)
        self.width(size: 20.0)
        self.setImage(unchecked, for: .normal)
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: .touchUpInside)
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked.toggle()
        }
    }
}
