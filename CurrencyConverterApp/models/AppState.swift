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

  private init() {
    loadPersistedHistory()
  }
    
  private func loadPersistedHistory() {
    Task {
      do {
        let persistedConversions = try PersistenceService().getHistory()
        // Ensure UI updates happen on the main thread
        await MainActor.run {
          self.conversions = persistedConversions
        }
      } catch {
        print("Failed to load conversion history: \(error.localizedDescription)")
      }
    }}
}
