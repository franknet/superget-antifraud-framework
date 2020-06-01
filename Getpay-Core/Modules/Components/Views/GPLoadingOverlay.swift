//
//  GPLoadingView.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 24/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import UIKit

public class GPLoadingOverlay {
    
    var overlayView : UIView!
    var activityIndicator : UIActivityIndicatorView!

    public class var shared: GPLoadingOverlay {
        struct Static {
            static let instance: GPLoadingOverlay = GPLoadingOverlay()
        }
        return Static.instance
    }

    init(){
        self.overlayView = UIView()
        self.activityIndicator = UIActivityIndicatorView()

        overlayView.frame = UIScreen.main.nativeBounds //CGRect(x: 0, y: 0, width: 80, height: 80)
        overlayView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        overlayView.layer.zPosition = 1

        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        activityIndicator.style = .whiteLarge
        overlayView.addSubview(activityIndicator)
    }

    public func showOverlay(view: UIView) {
        overlayView.center = view.center
        view.addSubview(overlayView)
        activityIndicator.startAnimating()
    }

    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}