//
//  GPModelTests.swift
//  Getpay-CoreTests
//
//  Created by Leandro Lopes on 24/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import XCTest
@testable import Getpay_Core

class DeviceTests: XCTestCase {

    func testMerchantAccess() {
        let merchant: GPMerchant? = GPMerchantRepository.getMercnaht()
        XCTAssertNotNil(merchant)
    }
    
    func testError() {
        let errorVC = GPErrorViewController(
            nibName: GPErrorViewController.nibName,
            bundle: GPErrorViewController.bundle)
        XCTAssertNotNil(errorVC)
    }
    
}
