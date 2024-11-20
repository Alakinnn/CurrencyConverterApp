//
//  CachedRate.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 20/11/2024.
//

import Foundation

struct CachedRate: Codable {
  let rate: Double
  let timestamp: Date
  
  var isExpired: Bool {
    Calendar.current.isDateInToday(timestamp) == false
  }
}

struct CurrencyPair: Codable, Hashable {
  let fromCurrency: Currency
  let toCurrency: Currency
}

