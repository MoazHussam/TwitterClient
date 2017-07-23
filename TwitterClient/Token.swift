//
//  Token.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/22/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import Foundation
import SwiftyJSON

class Token {
    
    private static let key = "AuthToken"
    private init() { }
    
    var shared = Token()
    
    static var authToken: String? {
        didSet {
            if let authToken = authToken {
                UserDefaults.standard.set(authToken, forKey: key)
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
    
    static func initialize(fromJsonObject json: JSON) {
        authToken = json[Constants.TwitterAPI.ParameterKeys.accessToken].string
    }
    
}
