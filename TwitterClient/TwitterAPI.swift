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
    case getFollowers(userID: String?, screenName: String?, count: Int?)
    case getTweets(userID: String?, screenName: String?, count: Int?)
}

extension TwitterAPI: TargetType {
    
    var baseURL: URL { return URL(string: Constants.TwitterAPI.baseURL)! }
    
    var path: String {
        switch self {
        case .oauth:
            return Constants.TwitterAPI.Methods.oauthPath
        case .getFollowers:
            return Constants.TwitterAPI.Methods.getFollowers
        case .getTweets:
            return Constants.TwitterAPI.Methods.getTweets
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .oauth:
            return .post
        case .getFollowers, .getTweets:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        var parameters: [String:Any] = [:]
        switch self {
        case .oauth:
            return [Constants.TwitterAPI.ParameterKeys.grantTypeKey:Constants.TwitterAPI.ParameterValues.grantTypeValue]
        case .getFollowers(userID: let userID, screenName: let name, count: let count), .getTweets(userID: let userID, screenName: let name, count: let count):
            if let userID = userID {
                parameters[Constants.TwitterAPI.ParameterKeys.userID] = userID
            }
            
            if let screenName = name {
                parameters[Constants.TwitterAPI.ParameterKeys.screenName] = screenName
            }
            
            parameters[Constants.TwitterAPI.ParameterKeys.count] = count ?? 10
            return parameters
        }
    }
    
    var parameterEncoding: ParameterEncoding {
       return URLEncoding.default
    }
    
    var sampleData: Data {
        switch self {
        case .oauth:
            return TwitterAPIDummyData.oauth
        case .getFollowers:
            return TwitterAPIDummyData.followers
        case .getTweets:
            return TwitterAPIDummyData.tweets
        }
    }
    
    var task: Task {
        return .request
    }

}
