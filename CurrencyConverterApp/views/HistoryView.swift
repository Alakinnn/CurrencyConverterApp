//
//  HistoryView.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 18/11/2024.
//

import SwiftUI

struct HistoryView: View {
  private let sampleConversions = [
    ConversionHistory(
      id: UUID(),
      fromCurrency: .usd,
      toCurrency: .eur,
      fromAmount: 100.0,
      toAmount: 85.25,
      exchangeRate: 0.8525,
      date: Date()
    ),
    ConversionHistory(
      id: UUID(),
      fromCurrency: .eur,
      toCurrency: .gbp,
      fromAmount: 50.0,
      toAmount: 42.85,
      exchangeRate: 0.857,
      date: Date().addingTimeInterval(-3600)
    ),
    ConversionHistory(
      id: UUID(),
      fromCurrency: .gbp,
      toCurrency: .jpy,
      fromAmount: 75.0,
      toAmount: 13875.0,
      exchangeRate: 185.0,
      date: Date().addingTimeInterval(-7200)
    )
  ]
  
  var body: some View {
    List {
      ForEach(sampleConversions) { history in
        VStack(alignment: .leading, spacing: 8) {
          HStack {
            Text("\(history.fromAmount.formatted()) \(history.fromCurrency.rawValue)")
              .font(.headline)
            Image(systemName: "arrow.right")
            Text("\(history.toAmount.formatted()) \(history.toCurrency.rawValue)")
              .font(.headline)
          }
          
          Text("Rate: 1 \(history.fromCurrency.rawValue) = \(history.exchangeRate.formatted()) \(history.toCurrency.rawValue)")
            .font(.subheadline)
            .foregroundColor(.secondary)
          
          Text(history.formattedDate)
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
      }
    }
    .navigationTitle("History")
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button("Clear") {
        }
      }
    }
  }
}

#Preview {
  HistoryView()
}
