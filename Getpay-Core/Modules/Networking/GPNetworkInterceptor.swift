//
//  GPNetworkService.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 20/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import Foundation
import Alamofire

final public class GPNetworkInterceptor: RequestInterceptor {
    
    // MARK: - RequestAdapter
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("adapting")
        var adaptedRequest = urlRequest
        let token = GPNetworkService.shared.authToken
        adaptedRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        completion(.success(adaptedRequest))
    }

    // MARK: - RequestRetrier
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if let response = request.task?.response as? HTTPURLResponse, let WWWheader = response.allHeaderFields["Www-Authenticate"] as? String, response.statusCode == 401, WWWheader == "Bearer realm=\"everywhere\"" {
            print("Refreshing token for retry...")
            GPNetworkService.shared.refreshTokens { (success) in
                print("Refreshed token, retrying request")
                completion(.retry)
            }
        } else {
            completion(.doNotRetry)
        }
    }
    
}
