//
//  NetworkServiceTests.swift
//  NetworkServiceTests
//
//  Created by Duong Tran Minh Hoang on 18/11/2024.
//

import XCTest
@testable import CurrencyConverterApp

// This file is AI-Generated
class MockURLProtocol: URLProtocol {
    static var mockData: Data?
    static var mockResponse: URLResponse?
    static var mockError: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = MockURLProtocol.mockError {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        
        if let response = MockURLProtocol.mockResponse {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let data = MockURLProtocol.mockData {
            client?.urlProtocol(self, didLoad: data)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}

final class NetworkServiceTests: XCTestCase {
  private var sut: NetworkService!
     private var session: URLSession!
     
     override func setUp() {
         super.setUp()
         let configuration = URLSessionConfiguration.ephemeral
         configuration.protocolClasses = [MockURLProtocol.self]
         session = URLSession(configuration: configuration)
         
         sut = NetworkService(session: session)
     }
     
     override func tearDown() {
         sut = nil
         session = nil
         MockURLProtocol.mockData = nil
         MockURLProtocol.mockResponse = nil
         MockURLProtocol.mockError = nil
         super.tearDown()
     }
    
  func testFetchExchangeRate_UnknownCode() async throws {
          // Given
          let mockResponse = """
          {
              "result": "error",
              "error-type": "unknown-code"
          }
          """
          
          // Use MockURLProtocol instead of MockURLSession
          MockURLProtocol.mockData = mockResponse.data(using: .utf8)
          MockURLProtocol.mockResponse = HTTPURLResponse(
              url: URL(string: "https://test.com")!,
              statusCode: 200,
              httpVersion: nil,
              headerFields: nil
          )
          
          // When/Then
          do {
              _ = try await sut.fetchExchangeRate(from: .eur, to: .gbp)
              XCTFail("Expected error wasn't thrown")
          } catch let error as NetworkService.NetworkError {
              XCTAssertEqual(error, .unknownCurrencyCode)
          }
      }
  }
