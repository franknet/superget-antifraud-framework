//
//  UserDefaultsExtension.swift
//  Getpay-Core
//
//  Created by Macbook Datum on 18/04/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public extension UserDefaults {
    static var shared: UserDefaults {
        if let suit = UserDefaults(suiteName: "com.getpay") {
            return suit
        }
        return UserDefaults.shared
    }

    /**
    - How to use: UserDefaults.shared.makeClearedInstance()
    */
    func makeClearedInstance() {
        removePersistentDomain(forName: "com.getpay")
    }
}
