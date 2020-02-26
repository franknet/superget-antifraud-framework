//
//  GPMerchantRepository.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 24/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation

public final class GPMerchantRepository {
    
    public static func getMercnaht() -> GPMerchant {
        let address = GPAddress(street: "rua",
                                number: "100",
                                complement: "complemento",
                                neighborhood: "bairro",
                                city: "cidade",
                                state: "estado",
                                zip: "cep",
                                country: "pais")
        
        let merchant = GPMerchant(id: 0,
                                  document: "doc",
                                  name: "name",
                                  tradeName: "tradeName",
                                  email: "email",
                                  address: address)
        return merchant
    }
    
    public static func setMerchant(merchant: GPMerchant) {
        
    }
    
    static func deleteMerchant() {
        
    }
    
}
