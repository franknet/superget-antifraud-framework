import UIKit

public class GNSuccessViewController: BaseViewController<GNSuccessView> {
    
    // MARK: - Public variables
    
    public var clousure: (() -> Void)?
    
    // MARK: - Initializers
    
    public init(title: String, subTitle: String? = nil) {
        super.init()
        customView.configure(title: title, subTitle: subTitle)
    }
    
    // MARK: - Override methods
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        animateSuccessImage()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(close), userInfo: nil, repeats: false)
    }
}

// MARK: - Private methods

extension GNSuccessViewController {
    
    @objc private func close() {
        dismiss(animated: true) {
            self.clousure?()
        }
    }

    private func animateSuccessImage() {
        let maxScale: CGFloat = 214 / 55
        UIView.animate(withDuration: 1, animations: {
            self.customView.successImageView.transform = CGAffineTransform(scaleX: maxScale, y: maxScale)
        }) { _ in
            UIView.animate(withDuration: 1, animations: {
                self.customView.successImageView.transform = CGAffineTransform(scaleX: maxScale * 0.5, y: maxScale * 0.5)
            })
        }
    }
}
