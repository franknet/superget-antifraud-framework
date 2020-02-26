//
//  UIViewExtension.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 12/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import UIKit

extension UIView {
     static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
       }

       static func instantiate(autolayout: Bool = true) -> Self {
           // generic helper function
           func instantiateUsingNib<T: UIView>(autolayout: Bool) -> T {
               let view = self.nib.instantiate() as! T
               view.translatesAutoresizingMaskIntoConstraints = !autolayout
               return view
           }
           return instantiateUsingNib(autolayout: autolayout)
       }
}

extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle: Bundle? = nil) -> UIView? {
      return UINib(
          nibName: nibNamed,
          bundle: bundle
      ).instantiate(withOwner: nil, options: nil)[0] as? UIView
  }
}

extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
