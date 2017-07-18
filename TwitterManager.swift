//
//  TwitterManager.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/18/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterManager {
    
    static let shared = TwitterManager()
    
    private init() { }
    
    var isLoggedIn: Bool {
        
        var loggedIn = false
        let store = Twitter.sharedInstance().sessionStore
        let session = store.session()
        if let session  = session {
            print("signed in as \(session.userID)");
            loggedIn = true
//            store.logOutUserID("2833689646")
        } else {
            print("Not Signed in")
            loggedIn = false
        }
        return loggedIn
        
    }
}
