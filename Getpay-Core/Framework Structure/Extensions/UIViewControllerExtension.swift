//
//  UIViewControllerExtension.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 12/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import UIKit

public extension UIViewController {

    var toastTag: Int {
        return 70457
    }

    @objc private func dismissToast() {
        hideToast()
    }

    func presentToast(message : String, showDismissButton: Bool = true, color: UIColor = #colorLiteral(red: 0.9490196078, green: 0.5843137255, blue: 0.2862745098, alpha: 1), extraMargin: CGFloat = 0) {
        let toastView = UIView(frame: .zero)
        let margin: CGFloat = 16

        view.addSubview(toastView)
        toastView.translatesAutoresizingMaskIntoConstraints = false
        toastView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin).isActive = true
        toastView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin).isActive = true
        toastView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        let contentView = UIView(frame: .zero)
        contentView.backgroundColor = color
        contentView.layer.cornerRadius = 6
        contentView.isHidden = true
        toastView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: toastView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: toastView.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -(margin+extraMargin)).isActive = true
        contentView.topAnchor.constraint(equalTo: toastView.topAnchor).isActive = true

        let messageLabel = UILabel(frame: .zero)
        messageLabel.text = message
        messageLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        messageLabel.numberOfLines = 0

        contentView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        var dismissButton: UIButton?

        if showDismissButton {
            let button = UIButton(frame: .zero)

            let action = #selector(dismissToast)
            button.addTarget(self, action: action, for: .touchUpInside)
            
            let image = UIImage.init(named: "gp_close_white", in: Bundle(identifier: "br.com.getnet.Getpay-Core"), compatibleWith: nil)
            
            button.setImage(image, for: .normal)
            dismissButton = button
            let buttonSize: CGFloat = 20
            contentView.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: buttonSize),
                button.heightAnchor.constraint(equalToConstant: buttonSize),
                button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -margin),
                button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
                ])
        }

        NSLayoutConstraint.activate([
            messageLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: margin),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin),
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin)
            ])

        if let dismissButton = dismissButton {
            messageLabel.rightAnchor.constraint(equalTo: dismissButton.leftAnchor, constant: -margin).isActive = true
        } else {
            messageLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -margin).isActive = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let contentViewSize = contentView.frame.size

            let balloonSize = contentViewSize.height
            let balloonFrame = CGRect(origin: .zero, size: CGSize(width: balloonSize,
                                                                  height: balloonSize))
            let balloonView = UIView(frame: balloonFrame)
            balloonView.backgroundColor = color
            balloonView.layer.cornerRadius = balloonSize * 0.5

            toastView.addSubview(balloonView)
            balloonView.translatesAutoresizingMaskIntoConstraints = false

            let widthConstraint = balloonView.widthAnchor.constraint(equalToConstant: balloonSize)
            let heightConstraint = balloonView.heightAnchor.constraint(equalToConstant: balloonSize)
            let bottomConstraint = balloonView.bottomAnchor.constraint(equalTo: toastView.bottomAnchor,
                                                                       constant: balloonSize)

            NSLayoutConstraint.activate([
                widthConstraint,
                heightConstraint,
                balloonView.centerXAnchor.constraint(equalTo: toastView.centerXAnchor),
                bottomConstraint
                ])

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                bottomConstraint.constant -= balloonSize + margin + extraMargin
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                }, completion: { _ in
                    widthConstraint.constant = contentViewSize.width
                    UIView.animate(withDuration: 0.5, animations: {
                        balloonView.layer.cornerRadius = 6
                        self.view.layoutIfNeeded()
                    }, completion: { _ in
                        contentView.isHidden = false
                        balloonView.removeFromSuperview()
                    })
                })
            })
        }
        toastView.tag = toastTag
    }

    func hideToast() {
        guard let toastView = view.subviews.first(where: { subview -> Bool in
            subview.tag == toastTag
        }) else { return }

        guard let constraint = toastView.constraints.first(where: { constraint -> Bool in
            guard let someView = constraint.secondItem as? UIView else { return false }
            return someView.tag == toastTag && constraint.secondAttribute == .bottom
        }) else { return }
 
        // mexendo nas constraints, removido pelo efeito de derretimento
        //constraint.constant =  toastView.frame.height + (constraint.constant * -1)
        UIView.animate(withDuration: 1, animations: {
            toastView.layer.frame.origin.y += toastView.frame.height + (constraint.constant * -1)
            // removido pelo efeito de derretimento
            //self.view.layoutIfNeeded()
        }) { _ in
            toastView.removeFromSuperview()
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

