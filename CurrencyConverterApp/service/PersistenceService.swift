//
//  PersistenceService.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 18/11/2024.
//

import Foundation

class PersistenceService {
  private let userDefaults: UserDefaults
  
  init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
  }
  
  func saveConversion(_ conversion: ConversionHistory) throws {
    var history = try getHistory()
    history.insert(conversion, at: 0)
    
    if history.count > Constants.maxHistoryItems {
      history.removeLast(history.count - Constants.maxHistoryItems)
    }
    
    let data = try JSONEncoder().encode(history)
    userDefaults.set(data, forKey: Constants.historyKey)
  }
  
  func getHistory() throws -> [ConversionHistory] {
    guard let data = userDefaults.data(forKey: Constants.historyKey) else {
      return []
    }
    return try JSONDecoder().decode([ConversionHistory].self, from: data)
  }
  
  func clearHistory() {
    userDefaults.removeObject(forKey: Constants.historyKey)
  }
}
