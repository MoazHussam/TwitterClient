//
//  AuthorizationPlugin.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/22/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import Foundation
import Moya
struct AuthorizationPlugin: PluginType {
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        
        var request = request
        switch target as! TwitterAPI {
        case .oauth:
            request.addValue("Basic \(encodedAuthenticationkeys)", forHTTPHeaderField: Constants.TwitterAPI.ParameterKeys.authorization)
        default:
            
            if let token = Token.authToken {
                request.addValue("Bearer \(token)", forHTTPHeaderField: Constants.TwitterAPI.ParameterKeys.authorization)
            } else {
                print("Can't Authoriza as there is no valid token")
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
