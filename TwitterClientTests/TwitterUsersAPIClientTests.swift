//
//  TwitterUsersAPIClientTests.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/21/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import XCTest
@testable import TwitterClient
import Moya

class TwitterUsersAPIClientTests: XCTestCase {
    
    var mockClient: MockTwitterUsersAPIClient!
    
    override func setUp() {
        
        super.setUp()
        mockClient = MockTwitterUsersAPIClient()
        
    }
    
    override func tearDown() {
        
        mockClient = nil
        super.tearDown()
        
    }
    
    func test_WhenValidNetwork_ReturnsData() {
        
        let expectation = self.expectation(description: "wait for get followers method")
        mockClient.webServiceProvider = self.getStubProvider(WithStatusCode: 200, withNetworkError: nil)
        mockClient.getFollowers(forUserID: "") { (error, tweets) in
            
            XCTAssertNil(error)
            XCTAssertNotNil(tweets)
            expectation.fulfill()
            
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func test_GetTweetsCallAcuallyRuns() {
        
        let expectation = self.expectation(description: "wait for get wteets method")
        let endpointClosure = { (target: TwitterAPI) -> Endpoint<TwitterAPI> in
            let url = target.baseURL.appendingPathComponent(target.path).absoluteString
            let endpoint = Endpoint<TwitterAPI>(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
            return endpoint.adding(newHTTPHeaderFields: ["Authorization":"Bearer AAAAAAAAAAAAAAAAAAAAANM81gAAAAAAPIcixaUYOt9ggvt3eQy80I1nY7k%3DhgMkFjeq3h6GMSMJRKQU0zxC3WmIEx0tLmJCyPE2POYirdQlU4"])
        }
        mockClient.webServiceProvider = MoyaProvider<TwitterAPI>(endpointClosure: endpointClosure, plugins: [NetworkLoggerPlugin()])
        
        mockClient.getFollowers(forUserID: "2833689646") { (error, tweets) in
            XCTAssertNil(error)
            XCTAssertNotNil(tweets)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    // MARK: - helper methods
    
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


extension TwitterUsersAPIClientTests {
    
    class MockTwitterUsersAPIClient: TwitterUsersAPIClient {
        
    }
}
