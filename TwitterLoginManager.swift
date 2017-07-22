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
                
                if let json = try? JSON(data: tokenData) {
                    Token.initialize(fromJsonObject: json)
                    completion(nil)
                } else {
                    print("Can't parse token data")
                    completion(.generalError)
                }
                
            }else {
                fatalError("Misconfiguration of TwitterAPIClient class")
            }
            
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
