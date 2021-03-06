//
//  TwitterAPIClient.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/19/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import Foundation
import Moya

protocol TwitterAPIClient: class {
    
    var webServiceProvider: MoyaProvider<TwitterAPI> { get set }
    
}

extension TwitterAPIClient {
    
    
    func performTwitterAPI(method: TwitterAPI, completion: ((Data?, TwitterAPIError?) -> Void)?) {
        
        DispatchQueue.global().async { [unowned self] in
            
            self.webServiceProvider.request(method) { (result) in
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
                    } else if 500...599 ~= response.statusCode {
                        data = nil
                        error = TwitterAPIError.serverError
                    } else {
                        data = nil
                        error = TwitterAPIError.generalError
                    }
                default:
                    data = nil
                    error = TwitterAPIError.networkError
                    
                }
                completion?(data, error)
            }
        }
        
    }
}
