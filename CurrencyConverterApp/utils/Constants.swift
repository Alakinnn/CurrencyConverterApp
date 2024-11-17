//
//  Constants.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 18/11/2024.
//

import Foundation
enum Constants {
//  THIS IS A FATAL SECURITY FLAW FOR DEVELOPMENT
//  FOR THE SAKE OF SIMPLICITY
//  IT IS IMPLEMENTED THIS WAY
//  example url: "https://v6.exchangerate-api.com/v6/YOUR-API-KEY/pair/EUR/GBP/AMOUNT"
  
    static let apiBaseURL = "https://v6.exchangerate-api.com/v6/c960cb3263b83d121ad8ccb5"
    static let historyKey = "conversionHistory"
    static let maxHistoryItems = 100
    
    enum NumberPad {
        static let spacing: CGFloat = 20
        static let buttonHeight: CGFloat = 60
    }
    
    enum Layout {
        static let cornerRadius: CGFloat = 10
        static let defaultPadding: CGFloat = 16
    }
}
