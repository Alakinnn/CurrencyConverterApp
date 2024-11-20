//
//  ExchangeRateCacheService.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 20/11/2024.
//

import Foundation

final class ExchangeRateCacheService {
  private var cache: [CurrencyPair: CachedRate] = [:]
  private let userDefaults: UserDefaults
  private let cacheKey = "exchangeRateCache"
  
  init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
    
    if let data = userDefaults.data(forKey: cacheKey),
       let loadedCache = try? JSONDecoder().decode([CurrencyPair: CachedRate].self, from: data) {
      self.cache = loadedCache
    }
  }
  
  private func saveCache() {
    if let data = try? JSONEncoder().encode(cache) {
      userDefaults.set(data, forKey: cacheKey)
    }
  }
  
  func getRate(from: Currency, to: Currency) -> Double? {
    let key = CurrencyPair(fromCurrency: from, toCurrency: to)
    guard let cachedRate = cache[key], !cachedRate.isExpired else {
      return nil
    }
    return cachedRate.rate
  }
  
  func saveRate(from: Currency, to: Currency, rate: Double) {
    let key = CurrencyPair(fromCurrency: from, toCurrency: to)
    let reverseKey = CurrencyPair(fromCurrency: to, toCurrency: from)
    
    let cachedRate = CachedRate(rate: rate, timestamp: Date())
    cache[key] = cachedRate
    cache[reverseKey] = CachedRate(rate: 1/rate, timestamp: Date())
    
    saveCache()
  }
  
  func clearCache() {
    cache.removeAll()
    userDefaults.removeObject(forKey: cacheKey)
  }
}
