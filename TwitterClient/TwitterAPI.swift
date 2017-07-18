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
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
       return URLEncoding.default
    }
    
    var sampleData: Data {
            return "Half measures are as bad as nothing at all.".data(using: .utf8)!
    }
    
    var task: Task {
        return .request
    }

    
}
