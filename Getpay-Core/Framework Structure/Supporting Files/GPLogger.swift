//
//  GPLogger.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 27/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public class GPLogger {
    public static func log(_ info: String) {
        #if DEBUG
            print("#log \(info)")
        #endif
    }
}
