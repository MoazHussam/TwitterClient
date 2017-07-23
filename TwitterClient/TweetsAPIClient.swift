//
//  TweetsAPIClient.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/21/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

class TweetsAPIClient: TwitterAPIClient {
    
    var webServiceProvider: MoyaProvider<TwitterAPI> = TwitterProviderFactory().defaultProvider
    
    func getTweets(forUserID userID: String, count: Int = 10, completion: @escaping (TwitterAPIError?, [Tweet]?) -> Void) {
        
        self.performTwitterAPI(method: .getTweets(userID: userID, screenName: nil, count: count)) { (resultData, error) in
            
            if let error = error {
                completion(error, nil)
            } else if let resultData = resultData {
                let data = JSON(data: resultData)
                let tweets = data.arrayValue.map({ (jsonTweet) -> Tweet in
                    return Tweet.initializeTweet(fromJsonObject: jsonTweet)
                })
                completion(nil, tweets)
            } else {
                fatalError("misconfiguration of TwitterApiClient class")
            }
            
        }
        
    }
    
}
