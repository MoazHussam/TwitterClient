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
            
            if let cachedTweets = getCachedTweets(forUser: user!) {
                completion(nil, cachedTweets)
                print("#Added Cached Tweets")
            }
            
            apiClient.getTweets(forUserID: userID, completion: { (error, tweets) in
                
                if let error = error {
                    completion(error, nil)
                } else if let tweets = tweets {
                    user?.tweets = NSSet(array: tweets)
                    completion(nil, tweets)
                    print("#Added ferched tweets")
                } else {
                    fatalError("Misconfiguration of TweetsAPIClient class")
                }
                
            })
        } else {
            completion(.noUserIsSpecified, nil)
        }

    }
    
    private func getCachedTweets(forUser user: TwitterUser) -> [Tweet]? {
        return Tweet.fetchTweets(forUser: user)
    }
    
    
    // MARK: - Helper Methods
    
    private func initializeWithDummyData(withTweeter tweeter: TwitterUser) -> [Tweet] {
        
        let tweet1 = Tweet.initializeTweet(id: "1", text: "This is my tweet number 1", created: Date(), tweeter: tweeter)
        let tweet2 = Tweet.initializeTweet(id: "2", text: "This is my tweet number 2", created: Date(), tweeter: tweeter)
        let tweet3 = Tweet.initializeTweet(id: "3", text: "This is my tweet number 3", created: Date(), tweeter: tweeter)
        let tweet4 = Tweet.initializeTweet(id: "4", text: "This is my tweet number 4", created: Date(), tweeter: tweeter)
        return [tweet1, tweet2, tweet3, tweet4]
        
    }
}
