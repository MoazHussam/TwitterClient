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
        
        static let baseURL = "https://api.twitter.com"
        static let twitterAPIKey = "FdE2cAr1c7IqJAvTdVxsBQjvP"
        static let twitterSecretKey = "onvvw2gvcvCdkSqekP0KmUnaFgQKS42hhMIzz34k42WLIVbn5o"
        
        struct Methods {
            
            static let oauthPath = "oauth2/token"
        }
        
        struct ParameterKeys {
            
            static let tokenAuthorize = "Authorize"
            static let grantTypeKey = "grant_type"
        }
        
        struct ParameterValues {
            
            static let grantTypeValue = "client_credentials"
        }
    }
}
