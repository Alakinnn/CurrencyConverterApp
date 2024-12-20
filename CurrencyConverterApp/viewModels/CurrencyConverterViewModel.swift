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
    self.networkService = networkService
    self.persistenceService = persistenceService
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
    guard !isLoading else { return }
    guard let amount = Double(fromAmount) else {
      error = "Please enter a valid amount"
      return
    }
    
    isLoading = true
    error = nil
    
    Task {
      do {
        // Fetch rate
        let rate = try await networkService.fetchExchangeRate(
          from: fromCurrency,
          to: toCurrency
        )
                
        // Update UI with results
        currentRate = rate
        let convertedAmount = amount * rate
        toAmount = String(format: "%.2f", convertedAmount)
        
        // Create and save conversion history
        let conversion = ConversionHistory(
          id: UUID(),
          fromCurrency: fromCurrency,
          toCurrency: toCurrency,
          fromAmount: amount,
          toAmount: convertedAmount,
          exchangeRate: rate,
          date: Date()
        )
        
        await AppState.shared.addConversion(conversion)
        
      } catch {
        self.error = error.localizedDescription
        self.toAmount = ""
        self.currentRate = nil
      }
      
      isLoading = false
    }
  }
  
  @MainActor 
  func swapCurrencies() {
    let tempCurrency = fromCurrency
    fromCurrency = toCurrency
    toCurrency = tempCurrency
    
    if !fromAmount.isEmpty {
      convert()
    }
  }
}
