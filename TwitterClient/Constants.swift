//
//  Constants.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/17/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct Colors {
        static let twitterBlue = UIColor(colorLiteralRed: 61/256, green: 167/256, blue: 244/256, alpha: 1)
    }
    
    struct Strings {
    }
    
    struct TwitterAPI {
        
        static let baseURL = "https://api.twitter.com/"
        static let twitterAPIKey = "FdE2cAr1c7IqJAvTdVxsBQjvP"
        static let twitterSecretKey = "onvvw2gvcvCdkSqekP0KmUnaFgQKS42hhMIzz34k42WLIVbn5o"
        static let dateFormat = "EEE MMM d HH:mm:ss ZZZ yyyy"

        struct Methods {
            
            static let oauthPath = "oauth2/token"
            static let getFollowers = "1.1/followers/list.json"
            static let getTweets = "1.1/followers/list.json?"
        }
        
        struct ParameterKeys {
            
            static let tokenAuthorize = "Authorize"
            static let grantTypeKey = "grant_type"
            static let cursor = "cursor"
            static let screenName = "screen_name"
            static let name = "name"
            static let userID = "user_id"
            static let count = "count"
            static let skipStatus = "skip_status"
            static let includeUserIdentities = "include_user_entities"
            static let id = "id_str"
            static let text = "text"
            static let dateCreated = "created_at"
            static let users = "users"
            static let bio = "description"
            static let coverPhoto = "profile_banner_url"
            static let profilePicture = "profile_image_url_https"
            
        }
        
        struct ParameterValues {
            
            static let grantTypeValue = "client_credentials"
        }
    }
}
