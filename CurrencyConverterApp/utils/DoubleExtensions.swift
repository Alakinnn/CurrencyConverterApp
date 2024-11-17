//
//  DoubleExtensions.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 18/11/2024.
//

import Foundation

extension Double {
    func formatted(decimals: Int = 2) -> String {
        String(format: "%.\(decimals)f", self)
    }
}
