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
            self.lblTitle.font = GPConstants.Fonts.ListItems.listTitle
        }
    }
    @IBOutlet public weak var lblSubTitle: UILabel! {
        didSet {
            self.lblSubTitle.font = GPConstants.Fonts.ListItems.listSubTitle
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
        userImage.backgroundColor = GPConstants.Colors.Backgrounds.defaultRed
    }
    
}
