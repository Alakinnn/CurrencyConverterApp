//
//  NetworkService.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 18/11/2024.
//

import Foundation

actor NetworkService {
  enum NetworkError: LocalizedError {
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
}
