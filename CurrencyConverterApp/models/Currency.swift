//
//  Currency.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 17/11/2024.
//

import Foundation

enum Currency: String, CaseIterable, Codable {
  case usd = "USD"
  case eur = "EUR"
  case gbp = "GBP"
  case jpy = "JPY"
  
  var symbol: String {
    switch self {
    case .usd: return "$"
    case .eur: return "€"
    case .gbp: return "£"
    case .jpy: return "¥"
    }
  }
}
