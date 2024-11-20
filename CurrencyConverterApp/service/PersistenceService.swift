//
//  PersistenceService.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 18/11/2024.
//

import Foundation

final class PersistenceService {
  private let userDefaults: UserDefaults
  private let lock = NSLock()
  
  init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
  }
  
  func saveConversion(_ conversion: ConversionHistory) throws {
    lock.lock()
    defer { lock.unlock() }
    
    var history = try getHistory()
    history.insert(conversion, at: 0)
    
    if history.count > Constants.maxHistoryItems {
      history.removeLast(history.count - Constants.maxHistoryItems)
    }
    
    let data = try JSONEncoder().encode(history)
    userDefaults.set(data, forKey: Constants.historyKey)
  }
  
  func getHistory() throws -> [ConversionHistory] {
    lock.lock()
    defer { lock.unlock() }
    
    guard let data = userDefaults.data(forKey: Constants.historyKey) else {
      return []
    }
    return try JSONDecoder().decode([ConversionHistory].self, from: data)
  }
  
  func clearHistory() {
    lock.lock()
    defer { lock.unlock() }
    
    userDefaults.removeObject(forKey: Constants.historyKey)
  }
}
