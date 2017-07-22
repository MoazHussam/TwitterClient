//
//  TwitterAPIError.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/19/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import Foundation

enum TwitterAPIError {
    case timeout
    case badRequest
    case networkError
    case serverError
    case generalError
    case noUserIsSpecified
}

//extension TwitterAPIError: Equatable {
//    
//    var rawValue: Int {
//        var rawValue: Int
//        switch self {
//        case .timeout:
//            rawValue = 0
//        case .badRequest:
//            rawValue = 1
//        case .networkError:
//            rawValue = 2
//        case .serverError:
//            rawValue = 3
//        }
//        return rawValue
//        
//    }
//
//    static public func ==(lhs: TwitterAPIError, rhs: TwitterAPIError) -> Bool {
//        return lhs.rawValue == rhs.rawValue
//    }
//    
//}
