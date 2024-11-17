//
//  AppState.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 17/11/2024.
//

import Foundation
import Observation

@Observable final class AppState {
  var selectedApp: Int = 0
  var conversions: [ConversionHistory] = []
  
  static let shared = AppState()
//  TODO: Add a method to load persisted histories from disk to history
  private init() {}
}
