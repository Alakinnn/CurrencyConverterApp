//
//  NetworkServiceTests.swift
//  NetworkServiceTests
//
//  Created by Duong Tran Minh Hoang on 18/11/2024.
//

import XCTest
@testable import CurrencyConverterApp // Make sure this matches your app name

// First create the MockURLSession
class MockURLSession: URLSession {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    
    override func data(
        from url: URL,
        delegate: URLSessionTaskDelegate? = nil
    ) async throws -> (Data, URLResponse) {
        if let mockError = mockError {
            throw mockError
        }
        return (
            mockData ?? Data(),
            mockResponse ?? URLResponse()
        )
    }
}

// Then your test class
final class NetworkServiceTests: XCTestCase {
    private var sut: NetworkService!
    private var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        sut = NetworkService(session: mockURLSession)
    }
    
    override func tearDown() {
        sut = nil
        mockURLSession = nil
        super.tearDown()
    }
    
    func testFetchExchangeRate_Success() async throws {
        // Given
        let expectedRate = 0.8412
        let mockResponse = """
        {
            "result": "success",
            "documentation": "https://www.exchangerate-api.com/docs",
            "terms_of_use": "https://www.exchangerate-api.com/terms",
            "time_last_update_unix": 1585267200,
            "time_last_update_utc": "Fri, 27 Mar 2020 00:00:00 +0000",
            "time_next_update_unix": 1585270800,
            "time_next_update_utc": "Sat, 28 Mar 2020 01:00:00 +0000",
            "base_code": "EUR",
            "target_code": "GBP",
            "conversion_rate": \(expectedRate),
            "conversion_result": 5.8884
        }
        """
        mockURLSession.mockData = mockResponse.data(using: .utf8)
        mockURLSession.mockResponse = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        // When
        let rate = try await sut.fetchExchangeRate(from: .EUR, to: .GBP)
        
        // Then
        XCTAssertEqual(rate, expectedRate)
    }
    
    func testFetchExchangeRate_UnknownCode() async throws {
        // Given
        let mockResponse = """
        {
            "result": "error",
            "error-type": "unknown-code"
        }
        """
        mockURLSession.mockData = mockResponse.data(using: .utf8)
        mockURLSession.mockResponse = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        // When/Then
        do {
          _ = try await sut.fetchExchangeRate(from: .eur, to: .gdp)
            XCTFail("Expected error wasn't thrown")
        } catch let error as NetworkService.NetworkError {
            XCTAssertEqual(error, .unknownCurrencyCode)
        }
    }
}
