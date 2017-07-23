//
//  TwitterLoginManager.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/18/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import UIKit
import TwitterKit
import Moya
import SwiftyJSON

class TwitterLoginManager: TwitterAPIClient {
    
    static private let sharedInstance = TwitterLoginManager()
    
    class var shared: TwitterLoginManager {
        return sharedInstance
    }
    
    var webServiceProvider: MoyaProvider<TwitterAPI> = TwitterProviderFactory().defaultProvider
    
    init() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(userLoggedIn), name: Constants.Notifications.userLoggedIn.name, object: nil)
    
    }
    
    func getToken(completion: @escaping (TwitterAPIError?) -> Void) {
        
        self.performTwitterAPI(method: .oauth) { (result, error) in
            
            if let error = error {
                completion(error)
            } else if let tokenData = result {
                let json = JSON(data: tokenData)
                Token.initialize(fromJsonObject: json)
                completion(nil)
            }else {
                fatalError("Misconfiguration of TwitterAPIClient class")
            }
            
        }
    }
    
    func logOutCurrentUser() {
        
        let store = Twitter.sharedInstance().sessionStore
        let session = store.session()

        if let session = session {
            store.logOutUserID(session.userID)
            NotificationCenter.default.post(Constants.Notifications.userLoggedOut)
        } else {
            return
        }
        
    }
    
    @objc func userLoggedIn() {
        
        self.getToken { (error) in
            
            if let error = error {
                print("Fetching authorization token failed with error: \(error)")
            } else {
                print("Authorization token fetched")
            }
            
        }
        
    }
    
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
    
    var currentLoggedInUser: TwitterUser? {
        
        var user: TwitterUser?
        let store = Twitter.sharedInstance().sessionStore
        let session = store.session()
        if let session  = session {
            user = TwitterUser.initializeTwitterUser(id: session.userID, handle: "", name: "")
        } else {
            user = nil
        }
        return user
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
