//
//  UserInfoDataController.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/21/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import Foundation

class UserInfoDataController {
    
    var apiClient = TweetsAPIClient()
    
    func tweets(forUser user: TwitterUser?, completion: @escaping (TwitterAPIError? ,[Tweet]?) -> Void) {
        
        if let userID = user?.id {
            apiClient.getTweets(forUserID: userID, completion: { (error, tweets) in
                
                if let error = error {
                    completion(error, nil)
                } else {
                    completion(nil, tweets)
                }
                
            })
        } else {
            completion(.noUserIsSpecified, nil)
        }

    }
    
    
    // MARK: - Helper Methods
    
    private func initializeWithDummyData(withTweeter tweeter: TwitterUser) -> [Tweet] {
        
        let tweet1 = Tweet(id: "1", text: "This is my tweet number 1", created: Date(), tweeter: tweeter)
        let tweet2 = Tweet(id: "2", text: "This is my tweet number 2", created: Date(), tweeter: tweeter)
        let tweet3 = Tweet(id: "3", text: "This is my tweet number 3", created: Date(), tweeter: tweeter)
        let tweet4 = Tweet(id: "4", text: "This is my tweet number 4", created: Date(), tweeter: tweeter)
        return [tweet1, tweet2, tweet3, tweet4]
        
    }
}
