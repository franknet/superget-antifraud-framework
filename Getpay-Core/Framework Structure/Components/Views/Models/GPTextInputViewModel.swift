//
//  SGTextInputViewModel.swift
//  SuperGetMobile
//
//  Created by Leandro dos Santos Lopes on 05/02/19.
//  Copyright © 2019 Getnet. All rights reserved.
//

import UIKit
import RxSwift

enum GPMaskTypes {
    case cpf
    case cnpj
    case cpfOrCnpj
    case cpfCnpjOrEmail
}

class GPTextInputViewModel: GPTextInputViewModelProtocol  {
    var inputValue = Variable<String>("")

    let placeholder: String
//    var isSecureTextEntry: Bool
    let mask: GPMaskTypes?
    let button: GPSwappableImageModel?
    let buttonActionType: GPTextInputComponentActionType?
    let keyboardType: UIKeyboardType

    var enable = false

    // MARK: - Init
    init(placeholder: String? = nil,
         isSecureTextEntry: Bool = false,
         mask: GPMaskTypes? = nil,
         button: GPSwappableImageModel? = nil,
         buttonActionType: GPTextInputComponentActionType? = nil,
         keyboardType: UIKeyboardType = UIKeyboardType.default) {

        self.placeholder = placeholder ?? ""
        self.mask = mask
        self.button = button
        self.buttonActionType = buttonActionType
        self.keyboardType = keyboardType
    }
}
