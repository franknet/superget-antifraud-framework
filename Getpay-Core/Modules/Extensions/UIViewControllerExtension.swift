import UIKit
import RxSwift

// MARK: - Private variables

fileprivate var ak_MyDisposeBag: UInt8 = 0

// MARK: - UIViewController extensions

public extension UIViewController {
    
    var disposeBag: DisposeBag {
        
        get {
            
            if let obj = objc_getAssociatedObject(self, &ak_MyDisposeBag) as? DisposeBag {
                return obj
            }
            let obj = DisposeBag()
            objc_setAssociatedObject(self, &ak_MyDisposeBag, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            return obj
        }
        
        set(newValue) {
            
            objc_setAssociatedObject(self, &ak_MyDisposeBag, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var toastTag: Int {
        return 70457
    }
    
    @objc func dismissToast() {
        hideToast()
    }
    
    /// TODO: Remover das chamadas o showDismissButton e extraMargin para que possamos remover da funcao
    func presentToast(message : String, showDismissButton: Bool = true, color: UIColor = GPColors.milhouse.color, extraMargin: CGFloat = 0) {
        
        let toastView = UIView()
        let contentView = UIView()
        let title = GPLabel(text: message, textColor: GPColors.maggie.color)
        let close = UIButton()
        
        view.addSubview(toastView, constraints: true)
        toastView.addSubview(contentView, constraints: true)
        contentView.addSubviews([title, close], constraints: true)
        
        toastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0).isActive = true
        toastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
        toastView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.backgroundColor = color
        contentView.layer.cornerRadius = 6.0
        contentView.isHidden = true
        contentView.applyAnchors(ofType: [.top, .leading, .trailing], to: toastView)
        contentView.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -16.0).isActive = true
        
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
        title.trailingAnchor.constraint(equalTo: close.leadingAnchor, constant: -16.0).isActive = true
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0).isActive = true
        title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0).isActive = true
        
        close.width(size: 24.0)
        close.height(size: 24.0)
        close.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        close.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0).isActive = true
        
        close.addTarget(self, action: #selector(dismissToast), for: .touchUpInside)
        close.setImage(GPAssets.gpClose.image, for: .normal)
        close.tintColor = GPColors.maggie.color
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
            let contentViewHeight = contentView.frame.size.height
            
            let animatedView = UIView(frame: CGRect(origin: .zero,
                                                    size: CGSize(width: contentViewHeight,
                                                                 height: contentViewHeight)))
            
            animatedView.backgroundColor = color
            animatedView.layer.cornerRadius = contentViewHeight * 0.5
            toastView.addSubview(animatedView, constraints: true)
            
            let widthConstraint = animatedView.widthAnchor.constraint(equalToConstant: contentViewHeight)
            widthConstraint.isActive = true
            animatedView.height(size: contentViewHeight)
            let bottomConstraint = animatedView.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: contentViewHeight)
            bottomConstraint.isActive = true
            animatedView.centerXAnchor.constraint(equalTo: toastView.centerXAnchor).isActive = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                bottomConstraint.constant -= contentViewHeight + 16.0
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                }, completion: { _ in
                    widthConstraint.constant = contentView.frame.size.width
                    UIView.animate(withDuration: 0.5, animations: {
                        animatedView.layer.cornerRadius = 6
                        self.view.layoutIfNeeded()
                    }, completion: { _ in
                        contentView.isHidden = false
                        animatedView.removeFromSuperview()
                    })
                })
            }
        }
        
        toastView.tag = toastTag
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.dismissToast()
        }
    }
    
    func hideToast() {
        guard let toastView = view.subviews.first(where: { subview -> Bool in
            subview.tag == toastTag
        }) else { return }
        
        guard let constraint = toastView.constraints.first(where: { constraint -> Bool in
            guard let someView = constraint.secondItem as? UIView else { return false }
            return someView.tag == toastTag && constraint.secondAttribute == .bottom
        }) else { return }
        
        UIView.animate(withDuration: 1, animations: {
            toastView.layer.frame.origin.y += toastView.frame.height + (constraint.constant * -1)
        }) { _ in
            toastView.removeFromSuperview()
        }
    }
}

// MARK: - Handling keyboard

public extension UIViewController {
    
    func addKeyboardNotifications() {
        
        let nc = NotificationCenter.default
        nc.addObserver(self,
                       selector: #selector(willShowKeyboard(notification:)),
                       name: UIResponder.keyboardWillShowNotification,
                       object: nil)
        nc.addObserver(self,
                       selector: #selector(didShowKeyboard(notification:)),
                       name: UIResponder.keyboardDidShowNotification,
                       object: nil)
        nc.addObserver(self,
                       selector: #selector(willHideKeyboard(notification:)),
                       name: UIResponder.keyboardWillHideNotification,
                       object: nil)
        nc.addObserver(self,
                       selector: #selector(didHideKeyboard(notification:)),
                       name: UIResponder.keyboardDidHideNotification,
                       object: nil)
        nc.addObserver(self,
                       selector: #selector(willChangeKeyboard(notification:)),
                       name: UIResponder.keyboardWillChangeFrameNotification,
                       object: nil)
    }
    
    @objc func willShowKeyboard(notification: Notification) {}
    @objc func didShowKeyboard(notification: Notification) {}
    @objc func willHideKeyboard(notification: Notification) {}
    @objc func didHideKeyboard(notification: Notification) {}
    @objc func willChangeKeyboard(notification: Notification) {}
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func mainDismiss(animated: Bool) {
        DispatchQueue.main.async {
            self.dismiss(animated: animated, completion: nil)
        }
    }
}
