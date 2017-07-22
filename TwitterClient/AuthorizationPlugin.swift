//
//  AuthorizationPlugin.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/22/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import Foundation
import Moya
class AuthorizationPlugin: PluginType {
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        
        var request = request
        switch target as! TwitterAPI {
        case .oauth:
            request.addValue("Basic \(encodedAuthenticationkeys)", forHTTPHeaderField: Constants.TwitterAPI.ParameterKeys.authorization)
        default:
            
            if let token = Token.authToken {
                request.addValue("Bearer \(token)", forHTTPHeaderField: Constants.TwitterAPI.ParameterKeys.authorization)
                print("Token is inserted successfully")
            } else {
                print("Start semaphore")
                let semaphore = DispatchSemaphore(value: 0)
                TwitterLoginManager.shared.getToken(completion: { [weak self] (error) in
                    
                    if let error = error {
                        print("Can't Authorize as there is no valid token.\nerror: \(error)")
                    } else {
                        request = self?.prepare(request, target: target) ?? request
                        print("Ended attempt to fetch token")
                    }
                    semaphore.signal()
                    print("Finish semaphore")
                    
                })
                semaphore.wait()
            }

        }
        return request
        
    }
    
    var encodedAuthenticationkeys: String {
        
        let tokenCredentials = Constants.TwitterAPI.twitterAPIKey + ":" + Constants.TwitterAPI.twitterSecretKey
        let credentialsData = tokenCredentials.data(using: String.Encoding.utf8, allowLossyConversion: true)!
        return credentialsData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
    }
    
}
