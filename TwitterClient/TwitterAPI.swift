//
//  TwitterAPI.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/18/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import Foundation
import Moya

enum TwitterAPI {
    case oauth
}

extension TwitterAPI: TargetType {
    
    var baseURL: URL { return URL(string: Constants.TwitterAPI.baseURL)! }
    
    var path: String {
        switch self {
        case .oauth:
            return Constants.TwitterAPI.Methods.oauthPath
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .oauth:
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .oauth:
            return [Constants.TwitterAPI.ParameterKeys.tokenAuthorize:"Basic \(encodedAuthenticationkeys)", Constants.TwitterAPI.ParameterKeys.grantTypeKey:Constants.TwitterAPI.ParameterValues.grantTypeValue]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
       return URLEncoding.default
    }
    
    var sampleData: Data {
            return "{\"token_type\":\"bearer\",\"access_token\":\"AAAAAAAAAAAAAAAAAAAAANM81gAAAAAAPIcixaUYOt9ggvt3eQy80I1nY7k%3DhgMkFjeq3h6GMSMJRKQU0zxC3WmIEx0tLmJCyPE2POYirdQlU4\"}".data(using: .utf8)!
    }
    
    var task: Task {
        return .request
    }

    var encodedAuthenticationkeys: String {
        
        let tokenCredentials = Constants.TwitterAPI.twitterAPIKey + ":" + Constants.TwitterAPI.twitterSecretKey
        let credentialsData = Data(base64Encoded: tokenCredentials)!
        return String(data: credentialsData, encoding: .utf8)!
        
    }
}
