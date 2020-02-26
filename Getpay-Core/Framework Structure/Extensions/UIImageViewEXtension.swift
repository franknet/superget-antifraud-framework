//
//  UIImageViewEXtension.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 18/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import UIKit

extension UIImageView{
    var circled : UIImageView{
        self.layer.cornerRadius = self.frame.width / 2;
        //self.layer.borderWidth = 2
        //self.layer.borderColor = UIColor.red.cgColor
        self.clipsToBounds = true
        return self
    }
}
