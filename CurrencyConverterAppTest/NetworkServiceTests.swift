//
//  NetworkServiceTests.swift
//  NetworkServiceTests
//
//  Created by Duong Tran Minh Hoang on 18/11/2024.
//

import XCTest
@testable import CurrencyConverterApp

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
  
  static func reset() {
    mockData = nil
    mockResponse = nil
    mockError = nil
  }
}

final class NetworkServiceTests: XCTestCase {
  private var sut: NetworkService!
  private var session: URLSession!
  private var cache: ExchangeRateCacheService!
  
  override func setUp() {
    super.setUp()
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    session = URLSession(configuration: configuration)
    cache = ExchangeRateCacheService()
    sut = NetworkService(session: session, cache: cache)
  }
  
  override func tearDown() {
    MockURLProtocol.reset()
    sut = nil
    session = nil
    cache = nil
    super.tearDown()
  }
  
  func testFetchExchangeRate_Success() async throws {
    // Given
    let expectedRate = 1.23
    let mockResponse = """
        {
            "result": "success",
            "conversion_rate": \(expectedRate),
            "base_code": "EUR",
            "target_code": "USD"
        }
        """
    
    MockURLProtocol.mockData = mockResponse.data(using: .utf8)
    MockURLProtocol.mockResponse = HTTPURLResponse(
      url: URL(string: "https://test.com")!,
      statusCode: 200,
      httpVersion: nil,
      headerFields: nil
    )
    
    // When
    let rate = try await sut.fetchExchangeRate(from: .eur, to: .usd)
    
    // Then
    XCTAssertEqual(rate, expectedRate)
  }
}
