//
//  TwitterUsersAPIClient.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/21/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

class TwitterUsersAPIClient: TwitterAPIClient {
    
    var webServiceProvider: MoyaProvider<TwitterAPI> = TwitterProviderFactory().defaultProvider
 
    
    func getFollowers(forUserID userID: String, count: Int = 10, completion: @escaping (TwitterAPIError?, [TwitterUser]?) -> Void) {
        
        self.performTwitterAPI(method: .getFollowers(userID: userID, screenName: nil, count: count)) { (resultData, error) in
            
            if let error = error {
                completion(error, nil)
            } else if let resultData = resultData {
                let data = JSON(data: resultData)
                let followers = data[Constants.TwitterAPI.ParameterKeys.users].arrayValue.map({ (follower) -> TwitterUser in
                    let folower = TwitterUser.initializeTwitterUser(fromJsonObject: follower)
                    folower.following = userID
                    return folower
                })
                completion(nil, followers)
            } else {
                fatalError("misconfiguration of TwitterApiClient class")
            }
            
        }
        
    }
}
