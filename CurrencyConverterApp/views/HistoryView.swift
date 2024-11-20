//
//  HistoryView.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 18/11/2024.
//

import SwiftUI

struct HistoryView: View {
  @Environment(AppState.self) private var appState
  
  var body: some View {
    List {
      ForEach(appState.conversions) { history in
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
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button("Clear") {
          appState.conversions.removeAll()
          Task {
            await PersistenceService().clearHistory()
          }
        }
      }
    }
  }
}

#Preview {
  HistoryView()
}
