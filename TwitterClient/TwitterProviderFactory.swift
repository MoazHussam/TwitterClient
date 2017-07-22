//
//  TwitterProviderFactory.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/22/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import Foundation
import Moya

class TwitterProviderFactory {
    
    var defaultProvider: MoyaProvider<TwitterAPI> {
        return MoyaProvider<TwitterAPI>(plugins: [AuthorizationPlugin()])
    }
    
}
