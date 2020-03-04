//
//  SGRoundedButton.swift
//  SuperGetMobile
//
//  Created by Leandro Lopes on 12/02/19.
//  Copyright © 2019 Getnet. All rights reserved.
//

import UIKit

@IBDesignable
public class GPRoundedButton: UIButton {
    
    // MARK: Properties
    
    var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.isEnabled = !self.isLoading
                self.isLoading ? self.showLoading() : self.hideLoading()
            }
        }
    }

    private let activityIndicator = UIActivityIndicatorView()
    
    private func showLoading() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = titleColor(for: .normal)
        self.addSubview(activityIndicator)
        self.bringSubviewToFront(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }

    private func hideLoading() {
        activityIndicator.removeFromSuperview()
    }

    override public var isEnabled: Bool {
        didSet {
            if self.isEnabled == false {
                refreshBorder(withColor: #colorLiteral(red: 0.642965138, green: 0.6429805756, blue: 0.6429722905, alpha: 1))
            } else {
                refreshBorder(withColor: borderColor.cgColor)
            }
        }
    }
    
    @IBInspectable
    var borderSize: CGFloat = 0 {
        didSet {
            refreshBorder(withSize: borderSize)
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet {
            refreshBorder(withColor: borderColor.cgColor)
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    
    @IBInspectable
    var backgroundImageColor: UIColor = UIColor.init(red: 0, green: 122/255.0, blue: 255/255.0, alpha: 1) {
        didSet {
            refreshColor(color: backgroundImageColor)
        }
    }
    
    // MARK: Life Cycle
    
    /// is for programmatically created buttons
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    /// is for Storyboard/.xib created buttons
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    /// Is called within the Storyboard editor itself for rendering @IBDesignable controls
    override public func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        refreshCorners(value: cornerRadius)
        refreshColor(color: backgroundImageColor)
        refreshBorder(withSize: borderSize)
        refreshBorder(withColor: borderColor.cgColor)
    }

    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }
    
    func refreshBorder(withSize size: CGFloat) {
        layer.borderWidth = size;
    }
    
    func refreshBorder(withColor color: CGColor) {
        layer.borderColor = color
    }
    
    func createImage(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), true, 0.0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        return image
    }
    
    func refreshColor(color: UIColor) {
        let image = createImage(color: color)
        setBackgroundImage(image, for: UIControl.State.normal)
        clipsToBounds = true
    }
    
    
}
