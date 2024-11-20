//
//  AppState.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 17/11/2024.
//

import Foundation
import Observation

@Observable final class AppState {
  var selectedTab: Int = 0
  var conversions: [ConversionHistory] = []
  
  static let shared = AppState()
  private let persistenceService = PersistenceService()
  
  private init() {
    Task {
      await loadConversions()
    }
  }
  
  private func loadConversions() async {
    do {
      self.conversions = try await persistenceService.getHistory()
    } catch {
      print("Failed to load conversion history: \(error.localizedDescription)")
    }
  }
  
  @MainActor
  func addConversion(_ conversion: ConversionHistory) async {
    do {
      conversions.insert(conversion, at: 0)
      try await persistenceService.saveConversion(conversion)
    } catch {
      conversions.removeFirst()
      print("Failed to save conversion: \(error.localizedDescription)")
    }
  }
}
