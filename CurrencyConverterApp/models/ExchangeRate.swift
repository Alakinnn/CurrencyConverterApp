//
//  ExchangeRate.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 17/11/2024.
//

import Foundation

struct ExchangeRate: Codable {
  let success: Bool
  let timestamp: TimeInterval
  let base: String
  let rates: [String: Double]
}
