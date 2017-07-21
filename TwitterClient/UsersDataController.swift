//
//  UsersDataController.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/21/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import Foundation


class UsersDataController {
    
    func getFollowers(completion: (TwitterAPIError?, [TwitterUser]?) -> Void) {
        
        completion(nil, initializeWithDummyData())
        
    }
    
    
    // MARK: - Helper methods
    
    private func initializeWithDummyData() -> [TwitterUser] {
        
        let tweeter1 = TwitterUser(id: "12345", handle: "@username 1", name: "User 1", bio: "Here goes the biography of the users.\nSome users may leave this field empty.", profilePicture: "")
        let tweeter2 = TwitterUser(id: "12345", handle: "@username 2", name: "User 2", bio: "Here goes the biography of the users.\nSome users may leave this field empty.", profilePicture: "")
        let tweeter3 = TwitterUser(id: "12345", handle: "@username 3", name: "User 3", bio: "Here goes the biography of the users.\nSome users may leave this field empty.", profilePicture: "")
        let tweeter4 = TwitterUser(id: "12345", handle: "@username 4", name: "User 4", bio: "Here goes the biography of the users.\nSome users may leave this field empty.", profilePicture: "")
        return [tweeter1, tweeter2, tweeter3, tweeter4]
        
    }
    
}
