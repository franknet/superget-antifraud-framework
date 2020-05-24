//
//  GPListItem.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 12/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import UIKit

public class GPListItemDisclousure: UITableViewCell {
    
    @IBOutlet public weak var lblTitle: UILabel! {
        didSet {
            self.lblTitle.font = FontFamily.Calibri.bold.font(size: 16.0)
        }
    }
    @IBOutlet public weak var lblSubTitle: UILabel! {
        didSet {
            self.lblSubTitle.font = FontFamily.Calibri.light.font(size: 14.0)
        }
    }
    @IBOutlet public weak var userImage: UIImageView! {
        didSet {
            setupImageView()
        }
    }
    @IBOutlet public weak var disclousureImage: UIImageView!
    
    private func setupImageView() {
        userImage.layer.cornerRadius = userImage.frame.width * 0.5
        userImage.layer.masksToBounds = true
        userImage.contentMode = .center
        userImage.backgroundColor = GPColors.homer.color
    }
    
}
