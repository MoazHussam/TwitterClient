//
//  TweetsAPIClientTest.swift
//  TwitterClient
//
//  Created by Moaz Ahmed on 7/21/17.
//  Copyright © 2017 Moaz Ahmed. All rights reserved.
//

import XCTest
@testable import TwitterClient
import Moya

class TweetsAPIClientTest: XCTestCase {
    
    var mockClient: MockTweetsAPIClient!
    
    override func setUp() {
        
        super.setUp()
        mockClient = MockTweetsAPIClient()
        
    }
    
    override func tearDown() {
        
        mockClient = nil
        super.tearDown()
        
    }
    
    func test_WhenValidNetwork_ReturnsData() {
        
        let expectation = self.expectation(description: "wait for get tweets method")
        mockClient.webServiceProvider = self.getStubProvider(WithStatusCode: 200, withNetworkError: nil)
        mockClient.getTweets(forUserID: "") { (error, tweets) in
            
            XCTAssertNil(error)
            XCTAssertNotNil(tweets)
            expectation.fulfill()
            
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func test_WhenValidData_ParsesDateSuccessfully() {
        
        let expectation = self.expectation(description: "wait for get tweets method")
        let sampleTweetStringDate = "Thu Apr 13 04:32:02 +0000 2017"
        let sampleDataDic = [Constants.TwitterAPI.ParameterKeys.dateCreated:sampleTweetStringDate]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.TwitterAPI.dateFormat
        let sampleDate = dateFormatter.date(from: sampleTweetStringDate)
        let sampleDataArr = [sampleDataDic, sampleDataDic]
        let sampleData = try? JSONSerialization.data(withJSONObject: sampleDataArr, options: .prettyPrinted)
        mockClient.webServiceProvider = self.getStubProvider(WithStatusCode: 200, withNetworkError: nil, andResponse: sampleData)
        mockClient.getTweets(forUserID: "") { (error, tweets) in
          XCTAssertEqual(sampleDate, tweets!.first!.created as Date?)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func test_WhenValidResponseData_ParsesTextSuccessfully() {
        
        let expectation = self.expectation(description: "wait for get tweets method")
        let sampleTweetText = "This is my first tweet"
        let sampleID = "123456789##"
        let sampleDataDic = [Constants.TwitterAPI.ParameterKeys.text:sampleTweetText, Constants.TwitterAPI.ParameterKeys.id: sampleID]
        let sampleDataArr = [sampleDataDic, sampleDataDic]
        let sampleData = try? JSONSerialization.data(withJSONObject: sampleDataArr, options: .prettyPrinted)
        mockClient.webServiceProvider = self.getStubProvider(WithStatusCode: 200, withNetworkError: nil, andResponse: sampleData)
        mockClient.getTweets(forUserID: sampleID) { (error, tweets) in
            XCTAssertEqual(tweets!.first!.text, sampleTweetText)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func test_WhenValidResponseData_ParsesIDSuccessfully() {
        
        let expectation = self.expectation(description: "wait for get tweets method")
        let sampleTweetID = "1234567"
        let sampleDataDic = [Constants.TwitterAPI.ParameterKeys.id:sampleTweetID]
        let sampleDataArr = [sampleDataDic, sampleDataDic]
        let sampleData = try? JSONSerialization.data(withJSONObject: sampleDataArr, options: .prettyPrinted)
        mockClient.webServiceProvider = self.getStubProvider(WithStatusCode: 200, withNetworkError: nil, andResponse: sampleData)
        mockClient.getTweets(forUserID: "") { (error, tweets) in
            XCTAssertEqual(tweets!.first!.id, sampleTweetID)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func test_WhenNetworkIsDown_ReturnsValidError() {
        
        let expectation = self.expectation(description: "wait for get tweets method")
        mockClient.webServiceProvider = self.getStubProvider(WithStatusCode: 200, withNetworkError: NSError())
        mockClient.getTweets(forUserID: "") { (error, tweets) in
            XCTAssertEqual(error, TwitterAPIError.networkError)
            XCTAssertNil(tweets)
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
        
        mockClient.getTweets(forUserID: "2833689646") { (error, tweets) in
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

extension TweetsAPIClientTest {
    
    class MockTweetsAPIClient: TweetsAPIClient {
        
    }
}
