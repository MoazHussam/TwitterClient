//
//  UsersDataController.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/21/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import Foundation


class UsersDataController {
    
    var usersClient = TwitterUsersAPIClient()
    
    func getFollowers(forUser user: TwitterUser?, completion: @escaping (TwitterAPIError?, [TwitterUser]?) -> Void) {
        
        //completion(nil, self.initializeWithDummyData())
        
        if let userID = user?.id {
            usersClient.getFollowers(forUserID: userID, completion: { (error, tweeters) in
                
                if let error = error {
                    completion(error, nil)
                } else {
                    completion(nil, tweeters)
                }
                
            })
        } else {
            completion(.noUserIsSpecified, nil)
        }
        
    }
    
    
    // MARK: - Helper methods
    
    private func initializeWithDummyData() -> [TwitterUser] {
        
        let tweeter1 = TwitterUser(id: "12345", handle: "@username 1", name: "User 1", bio: "Here goes the biography of the users.\nSome users may leave this field empty.\nHere goes the biography of the users.\nSome users may leave this field empty.", profilePicture: "")
        let tweeter2 = TwitterUser(id: "12345", handle: "@username 2", name: "User 2", bio: "Here goes the biography of the users.\nSome users may leave this field empty.\nHere goes the biography of the users.\nSome users may leave this field empty.\nHere goes the biography of the users.\nSome users may leave this field empty.", profilePicture: "")
        let tweeter3 = TwitterUser(id: "12345", handle: "@username 3", name: "User 3", bio: "Here goes the biography of the users.\nSome users may leave this field empty.", profilePicture: "")
        let tweeter4 = TwitterUser(id: "12345", handle: "@username 4", name: "User 4", bio: "Here goes the biography of the users.\nSome users may leave this field empty.", profilePicture: "")
        let tweeter5 = TwitterUser(id: "1345", handle: "username 5", name: "User 5")
        return [tweeter1, tweeter2, tweeter5, tweeter3, tweeter4, tweeter1, tweeter5, tweeter2, tweeter3, tweeter4, tweeter5]
        
    }
    
}
