//
//  NetworkService.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 18/11/2024.
//

import Foundation

actor NetworkService {
  enum NetworkError: LocalizedError, Equatable {
    case invalidURL
    case invalidResponse
    case apiError(String)
    
    case unknownCurrencyCode
    case conversionError(String)
    
    var errorDescription: String? {
      switch self {
      case .invalidURL:
        return "Invalid URL"
      case .invalidResponse:
        return "Invalid response from server"
      case .apiError(let message):
        return message
      case .unknownCurrencyCode:
        return "Unknown currency code"
      case .conversionError(let message):
        return message
      }
    }
  }
  
  private let session: URLSession
  private let cache: ExchangeRateCacheService
  
  init(session: URLSession = .shared, cache: ExchangeRateCacheService = ExchangeRateCacheService()) {
    self.session = session
    self.cache = cache
  }
  
  func fetchExchangeRate(from: Currency, to: Currency) async throws -> Double {
// Check cache first
    if let cachedRate = cache.getRate(from: from, to: to) {
      return cachedRate
    }
    
    let urlString = "\(Constants.apiBaseURL)/pair/\(from.rawValue)/\(to.rawValue)"
    
//    Construcutre an URL object
    guard let url = URL(string: urlString) else {
      throw NetworkError.invalidURL
    }
    
    let (data, response) = try await session.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
      throw NetworkError.invalidResponse
    }
    
    let exchangeRate = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
    
    // Handle error response
    if exchangeRate.result == "error" {
      switch exchangeRate.errorType {
      case "unknown-code":
        throw NetworkError.unknownCurrencyCode
      default:
        throw NetworkError.apiError(exchangeRate.errorType ?? "Unknown error")
      }
    }
    
    // Handle success response
    guard exchangeRate.result == "success",
          let rate = exchangeRate.conversionRate else {
      throw NetworkError.conversionError("Conversion rate not found")
    }
    
    cache.saveRate(from: from, to: to, rate: rate)
    
    return rate
  }
}
