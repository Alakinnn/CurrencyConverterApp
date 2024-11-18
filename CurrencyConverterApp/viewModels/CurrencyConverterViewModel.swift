//
//  CurrencyConverterViewModel.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 18/11/2024.
//

import Foundation
import Observation

@Observable
final class CurrencyConverterViewModel {
  var fromAmount = ""
  var toAmount = ""
  var fromCurrency: Currency = .usd
  var toCurrency: Currency = .eur
  var isLoading = false
  var error: String?
  var currentRate: Double?
  
  private let networkService: NetworkService
  private let persistenceService: PersistenceService
  
  init(
  networkService: NetworkService = NetworkService(),
  persistenceService: PersistenceService = PersistenceService()
  ) {
    self.networkService = NetworkService()
    self.persistenceService = PersistenceService()
  }
}
