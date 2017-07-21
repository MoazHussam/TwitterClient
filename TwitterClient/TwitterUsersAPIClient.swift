//
//  TwitterUsersAPIClient.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/21/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import Foundation
import Moya

class TwitterUsersAPIClient: TwitterAPIClient {
    
    var webServiceProvider: MoyaProvider<TwitterAPI> = MoyaProvider<TwitterAPI>()
 
    func getFollowers(forUserID userID: String, count: Int = 10, completion: @escaping (TwitterAPIError?, [TwitterUser]?) -> Void) {
        
        self.performTwitterAPI(method: .getFollowers(userID: userID, screenName: nil, count: count)) { (resultData, error) in
            
            if let error = error {
                completion(error, nil)
            } else if let resultData = resultData {
                let data = try? JSON(data: resultData)
                let followers = data?[Constants.TwitterAPI.ParameterKeys.users].arrayValue.map({ (follower) -> TwitterUser in
                    return TwitterUser(fromJsonObject: follower)
                })
                completion(nil, followers)
            } else {
                fatalError("misconfiguration of TwitterApiClient class")
            }
            
        }
        
    }
}
