//
//  ConversionHistory.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 17/11/2024.
//

import Foundation

struct ConversionHistory: Identifiable, Codable {
  let id: UUID
  let fromCurrency: Currency
  let toCurrency: Currency
  let fromAmount: Double
  let toAmount: Double
  let exchangeRate: Double
  let date: Date
}
