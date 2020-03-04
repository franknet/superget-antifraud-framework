//
//  GPNetworkingService.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 20/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation
import Alamofire

final public class GPNetworkService {
    
    public static let shared = GPNetworkService()
    private let interceptor = GPNetworkInterceptor()
    
    private init(){}
    
    public var authToken: String {
        return "012301230"
    }
    
    public var ecNumber: String {
        return "123123"
    }
    
    public func Auth() {
        AF.request("https://servicosportais.getnet.com.br/auth/realms/external/protocol/openid-connect/token", interceptor: interceptor).response { response in
            switch response.result {
            case .success(let data):
                print("success \(String(describing: data))")
            case .failure(let data):
                // Could not get anything from API
                print("failure \(data)")
            }
        }
    }
    
    public func refreshTokens(completion: (Bool)->Void) {
        AF.request("https://servicosportais.getnet.com.br/auth/realms/external/protocol/openid-connect/token", interceptor: interceptor).response { response in
            print(response)
        }
    }
    
}
