//
//  ExchangeRate.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 17/11/2024.
//

import Foundation

// TODO: Change class name to ExchangeRateResponse
struct ExchangeRateResponse: Codable {
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
  
//  JSON keys to ExchangeRate class response
  enum CodingKeys: String, CodingKey {
    case result
    case conversionRate = "conversion_rate"
    case errorType = "error-type"
    case baseCode = "base_code"
    case targetCode = "target_code"
    case conversionResult = "conversion_result"
    case documentation
    case termsOfUse = "terms_of_use"
    case timeLastUpdateUnix = "time_last_update_unix"
    case timeLastUpdateUtc = "time_last_update_utc"
    case timeNextUpdateUnix = "time_next_update_unix"
    case timeNextUpdateUtc = "time_next_update_utc"
  }
}
