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
  
  func numberPressed(_ number: Int) {
    if fromAmount == "0" {
      fromAmount = "\(number)"
    } else {
      fromAmount += "\(number)"
    }
  }
  
  func decimalPressed() {
    if !fromAmount.contains(".") {
      fromAmount += "."
    }
  }
  
  func clearPressed() {
    fromAmount = ""
    toAmount = ""
    currentRate = nil
  }
  
  @MainActor
  func convert() {
    guard let amount = Double(fromAmount) else {
      error = "Please enter a valid amount"
      return
    }
    
    Task {
      do {
        isLoading = true
        error = nil
        
        let rate = try await networkService.fetchExchangeRate(
          from: fromCurrency,
          to: toCurrency
        )
        
        currentRate = rate
        let convertedAmount = amount * rate
        toAmount = String(format: "%.2f", convertedAmount)
        
        let conversion = ConversionHistory(
          id: UUID(),
          fromCurrency: fromCurrency,
          toCurrency: toCurrency,
          fromAmount: amount,
          toAmount: convertedAmount,
          exchangeRate: rate,
          date: Date()
        )
        
        try persistenceService.saveConversion(conversion)
        AppState.shared.conversions.insert(conversion, at: 0)
        
      } catch {
        self.error = error.localizedDescription
        toAmount = ""
        currentRate = nil
      }
      
      isLoading = false
    }
  }
}
