//
//  TwitterAPIClientTests.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/19/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import XCTest
@testable import TwitterClient
import Moya

class TwitterAPIClientTests: XCTestCase {
    
    var mockClient: MockTwitterAPIClient!
    
    override func setUp() {
        
        super.setUp()
        mockClient = MockTwitterAPIClient()
        
    }
    
    override func tearDown() {
        
        mockClient = nil
        super.tearDown()
    }
    
    func test_HasAccessibleProvider() {
        mockClient.webServiceProvider = MoyaProvider<TwitterAPI>()
    }
    
    func test_whenRequestIsValidAndConnectionIsSuccessful_ReturnsVAlidData() {
        
        let expectation = self.expectation(description: "Wait for TwitterAPI Method Call")
        mockClient.webServiceProvider = getStubProvider(WithStatusCode: 200, withNetworkError: nil)
        mockClient.performTwitterAPI(method: .oauth) { (data, error) in
            expectation.fulfill()
            let expectedResponseData = TwitterAPIDummyData.oauth
            XCTAssertEqual(data, expectedResponseData)
        }
        self.waitForExpectations(timeout: 10, handler: nil)

    }
    
    func test_whenBadRequest_returnsValidError() {
        
        let expectation = self.expectation(description: "Wait for Moonshot Method Call")
        mockClient.webServiceProvider = getStubProvider(WithStatusCode: 400, withNetworkError: nil)
        mockClient.performTwitterAPI(method: .oauth) { (response, error) in
            XCTAssertEqual(error, TwitterAPIError.badRequest)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func test_whenTimeout_ReturnsValidError() {
        
        let expectation = self.expectation(description: "Wait for Moonshot Method Call")
        mockClient.webServiceProvider = getStubProvider(WithStatusCode: 200, withNetworkError: NSError())
        mockClient.performTwitterAPI(method: .oauth) { (response, error) in
            XCTAssertEqual(error, TwitterAPIError.networkError)
            XCTAssertNil(response)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func test_WhenServerError_ReturnsValidError() {
        
        let expectation1 = self.expectation(description: "Wait for Twitter Method Call")
        let expectation2 = self.expectation(description: "Wait for Twitter Method Call")
        let expectation3 = self.expectation(description: "Wait for Twitter Method Call")
        mockClient.webServiceProvider = getStubProvider(WithStatusCode: 500, withNetworkError: nil)
        mockClient.performTwitterAPI(method: .oauth) { (response, error) in
            XCTAssertEqual(error, TwitterAPIError.serverError)
            XCTAssertNil(response)
            expectation1.fulfill()
        }
        mockClient.webServiceProvider = getStubProvider(WithStatusCode: 501, withNetworkError: nil)
        mockClient.performTwitterAPI(method: .oauth) { (response, error) in
            XCTAssertEqual(error, TwitterAPIError.serverError)
            XCTAssertNil(response)
            expectation2.fulfill()
        }
        mockClient.webServiceProvider = getStubProvider(WithStatusCode: 599, withNetworkError: nil)
        mockClient.performTwitterAPI(method: .oauth) { (response, error) in
            XCTAssertEqual(error, TwitterAPIError.serverError)
            XCTAssertNil(response)
            expectation3.fulfill()
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

extension TwitterAPIClientTests {
    
    class MockTwitterAPIClient: TwitterAPIClient {
        
        var webServiceProvider: MoyaProvider<TwitterAPI> = MoyaProvider<TwitterAPI>()
        
    }
}
