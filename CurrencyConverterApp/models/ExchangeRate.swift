//
//  ExchangeRate.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 17/11/2024.
//

import Foundation

// TODO: Change class name to ExchangeRateResponse
struct ExchangeRate: Codable {
  let result: String
  let conversionRate: Double?
  let errorType: String?
  let baseCode: String?
  let targetCode: String?
  let conversionResult: Double?
  let documentation: String?
  let termsOfUse: String?
  let timeLastUpdateUnix: TimeInterval?
  let timeLastUpdateUtc: String?
  let timeNextUpdateUnix: TimeInterval?
  let timeNextUpdateUtc: String?
}
