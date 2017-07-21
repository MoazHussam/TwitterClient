//
//  TwitterAPIClient.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/19/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import Foundation
import Moya

protocol TwitterAPIClient {
    
    var webServiceProvider: MoyaProvider<TwitterAPI> { get set }
    
}

extension TwitterAPIClient {
    
    
    func performTwitterAPI(method: TwitterAPI, completion: ((Data?, TwitterAPIError?) -> Void)?) {
        
        webServiceProvider.request(.oauth) { (result) in
            var data: Data?
            var error: TwitterAPIError?
            switch result {
            case .success(let response):
                if 200...299 ~= response.statusCode {
                    data = response.data
                    error = nil
                } else if response.statusCode == 400 {
                    data = nil
                    error = TwitterAPIError.badRequest
                } else {
                    data = nil
                    error = TwitterAPIError.serverError
                }
            default:
                data = nil
                error = TwitterAPIError.networkError
                
            }
            completion?(data, error)
        }
        
    }
}
