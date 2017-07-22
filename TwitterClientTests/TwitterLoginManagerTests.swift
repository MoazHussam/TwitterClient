//
//  TwitterLoginManagerTests.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/22/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import XCTest
@testable import TwitterClient
import Moya

class TwitterLoginManagerTests: XCTestCase {
    
    var manager: MockTwitterLoginManager!
    override func setUp() {
        
        super.setUp()
        manager = MockTwitterLoginManager.shared
        
    }
    
    override func tearDown() {
        
        manager = nil
        Token.authToken = nil
        super.tearDown()
        
    }
    
    func test_getTokenCallSuccessfullyRuns() {
        
        let expectation = self.expectation(description: "Wait for get token method")
        manager.webServiceProvider = MoyaProvider<TwitterAPI>(plugins: [AuthorizationPlugin()])
        manager.getToken { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func test_whenValidResponse_TokenIsSavedCorrectley() {
        
        let expectation = self.expectation(description: "Wait for get token method")
        let testToken = "123456"
        let sampleResponse = [Constants.TwitterAPI.ParameterKeys.accessToken:testToken]
        let sampleResponseData = try? JSONSerialization.data(withJSONObject: sampleResponse, options: .prettyPrinted)
        manager.webServiceProvider = self.getStubProvider(WithStatusCode: 200, withNetworkError: nil, andResponse: sampleResponseData)
        manager.getToken { (error) in
            
            XCTAssertNil(error)
            XCTAssertEqual(testToken, Token.authToken!)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    // MARK: - Helper Methods
    
    private func getStubProvider(WithStatusCode statusCode: Int, withNetworkError networkError: NSError?, andResponse response: Data? = nil) -> MoyaProvider<TwitterAPI>  {
        
        let endpointClosure = { (target: TwitterAPI) -> Endpoint<TwitterAPI> in
            let url = target.baseURL.appendingPathComponent(target.path).absoluteString
            if let networkError = networkError {
                return Endpoint(url: url, sampleResponseClosure: {.networkError(networkError)}, method: target.method, parameters: target.parameters)
            } else {
                var endpoint: Endpoint<TwitterAPI>
                if let response = response {
                    endpoint = Endpoint(url: url, sampleResponseClosure: {.networkResponse(statusCode, response)}, method: target.method, parameters: target.parameters)
                } else {
                    endpoint = Endpoint(url: url, sampleResponseClosure: {.networkResponse(statusCode, target.sampleData)}, method: target.method, parameters: target.parameters)
                }
                return endpoint
            }
        }
        return MoyaProvider<TwitterAPI>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        
    }
    
}

extension TwitterLoginManagerTests {
    
    class MockTwitterLoginManager: TwitterLoginManager {
        
        static private var sharedInstance: MockTwitterLoginManager! = MockTwitterLoginManager()
        override class var shared: MockTwitterLoginManager {
            set {
                sharedInstance = newValue
            }
            get {
                return sharedInstance
            }
        }
    }
    
}
