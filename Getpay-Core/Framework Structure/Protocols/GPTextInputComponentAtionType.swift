//
//  GPTextInputComponentAtionType.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 14/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

enum GPTextInputComponentActionType {
    case clear
    case show
}

protocol GPTextInputViewModelProtocol {
    var placeholder: String { get }
    var mask: GPMaskTypes? { get }
    var button: GPSwappableImageModel? { get }
    var buttonActionType: GPTextInputComponentActionType? { get }
}

protocol GPSwappableImageModel {
    var enabled: String { get }
    var highlighted: String { get }
}
