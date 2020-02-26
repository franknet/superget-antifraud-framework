//
//  GetpayConstants.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 11/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import UIKit

public enum GPConstants {
    
    public enum Colors {
        public enum Buttons {
            public static let primary: UIColor = #colorLiteral(red: 0.8705882353, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
            public static let secondary: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            public static let disabled: UIColor = #colorLiteral(red: 0.737254902, green: 0.768627451, blue: 0.8, alpha: 1)
            public static let containedPressed: UIColor = #colorLiteral(red: 0.9411764706, green: 0.3803921569, blue: 0.4, alpha: 1)
            public static let outlinedPressed: UIColor = #colorLiteral(red: 0.9843137255, green: 0.8235294118, blue: 0.8274509804, alpha: 1)
            public static let textPressed: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        public enum ListItems {
            public static let listExtendedHeaderTitle = #colorLiteral(red: 0.1333333333, green: 0.1490196078, blue: 0.1607843137, alpha: 1)
            public static let listNavigationHeaderTitle = #colorLiteral(red: 0.1333333333, green: 0.1490196078, blue: 0.1607843137, alpha: 1)
            public static let listHeaderInput = #colorLiteral(red: 0.4039215686, green: 0.4431372549, blue: 0.4784313725, alpha: 1)
            public static let listTitle: UIColor = #colorLiteral(red: 0.1333333333, green: 0.1490196078, blue: 0.1607843137, alpha: 1)
            public static let listSubtitleTitle: UIColor = #colorLiteral(red: 0.4, green: 0.4392156863, blue: 0.4784313725, alpha: 1)
        }
        
        public enum Backgrounds {
            public static let defaultRed: UIColor = #colorLiteral(red: 0.8705882353, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
            public static let defaultColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            public static let receipt: UIColor = #colorLiteral(red: 0.9607843137, green: 0.968627451, blue: 0.9803921569, alpha: 1)
            public static let receiptItemGreen: UIColor = #colorLiteral(red: 0.9294117647, green: 0.9764705882, blue: 0.9294117647, alpha: 1)
            public static let toastViewWarning: UIColor = #colorLiteral(red: 1, green: 0.6509803922, blue: 0.3019607843, alpha: 1)
            public static let toastViewWarningShadow: UIColor = #colorLiteral(red: 1, green: 0.6509803922, blue: 0.3019607843, alpha: 0.6)
            public static let toastViewSuccess: UIColor = #colorLiteral(red: 0.5294117647, green: 0.8470588235, blue: 0.5137254902, alpha: 1)
            public static let toastViewSuccessShadow: UIColor = #colorLiteral(red: 0.5294117647, green: 0.8470588235, blue: 0.5137254902, alpha: 0.6)
        }
        
        public enum Inputs {
            public static let borderDefault: UIColor = #colorLiteral(red: 0.737254902, green: 0.768627451, blue: 0.8, alpha: 1)
            public static let borderFirstResponder: UIColor = #colorLiteral(red: 0.8705882353, green: 0.1921568627, blue: 0.1921568627, alpha: 1)
            public static let borderDisabled: UIColor = #colorLiteral(red: 0.8823529412, green: 0.9019607843, blue: 0.9215686275, alpha: 1)
            public static let textDefault: UIColor = #colorLiteral(red: 0.1333333333, green: 0.1490196078, blue: 0.1607843137, alpha: 1)
            public static let textPlaceholder: UIColor = #colorLiteral(red: 0.4, green: 0.4392156863, blue: 0.4784313725, alpha: 1)
        }
        

    }
    
    public enum Fonts {
        public enum ListItems {
            public static let listExtendedHeaderTitle = UIFont(name: "CalibriBold", size: 24)
            public static let listNavigationHeaderTitle = UIFont(name: "Calibri", size: 20)
            public static let listHeaderInput = UIFont(name: "CalibriRegular", size: 18)
            public static let listTitle = UIFont(name: "CalibriBold", size: 16)
            public static let listSubTitle = UIFont(name: "Calibri", size: 14)
        }
        public enum ToastView {
            public static let defaultText = UIFont(name: "Calibri", size: 14)
        }
        public enum Buttons {
            public static let defaultFont = UIFont(name: "Calibri", size: 16)
        }
    }
    
    public enum Sizes {
        public enum Buttons {
            public static let height = 40
        }
        public enum ListItems {
            public static let size1 = 88
            public static let size2 = 72
            public static let size3 = 64
            public static let size4 = 56
            public static let size5 = 48
        }
        
        public enum ToastView {
            public static let minimumSize = 48
            
        }
        public enum Toolbar {
            public static let defaultHeight = 56
            public static let defaultExtended = 128
        }
    }
    
    public enum Margins {
        public enum views {
            static let defaultMargin = 16
            static let defaultMarginTop = 16
            static let defaultMarginBotton = 16
            static let defaultMarginRight = 16
            static let defaultMarginLeft = 16
        }
    }

    
}
