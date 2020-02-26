//
//  GPListDisclousureCellTableViewCell.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 12/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import UIKit

public
class GPListDisclousureCellTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var disclousureImage: UIImageView!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
