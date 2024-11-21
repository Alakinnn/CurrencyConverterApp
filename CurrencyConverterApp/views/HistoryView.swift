//
//  HistoryView.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 18/11/2024.
//

import SwiftUI

struct HistoryView: View {
  @Environment(AppState.self) private var appState
  @State private var selectedConversion: ConversionHistory?
  @State private var searchText = ""
  
  private var filteredConversions: [ConversionHistory] {
    if searchText.isEmpty {
      return appState.conversions
    }
    return appState.conversions.filter { conversion in
      let searchLower = searchText.lowercased()
      return conversion.fromCurrency.rawValue.lowercased().contains(searchLower) ||
      conversion.toCurrency.rawValue.lowercased().contains(searchLower) ||
      String(conversion.fromAmount).contains(searchLower) ||
      String(conversion.toAmount).contains(searchLower)
    }
  }
  
  private var groupedConversions: [(String, [ConversionHistory])] {
    let grouped = Dictionary(grouping: filteredConversions) { conversion -> String in
      let calendar = Calendar.current
      if calendar.isDateInToday(conversion.date) {
        return "Today"
      } else if calendar.isDateInYesterday(conversion.date) {
        return "Yesterday"
      } else {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: conversion.date)
      }
    }
    return grouped.sorted { $0.0 > $1.0 }
  }
  
  var body: some View {
    VStack(spacing: 0) {
      // Search bar
      searchBar
      
      // List of conversions
      List {
        ForEach(groupedConversions, id: \.0) { date, conversions in
          Section(header: Text(date)
            .font(.headline)
            .foregroundStyle(.secondary)
            .textCase(nil)
          ) {
            ForEach(conversions) { history in
              HistoryItemView(history: history)
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .onTapGesture {
                  withAnimation {
                    if selectedConversion?.id == history.id {
                      selectedConversion = nil
                    } else {
                      selectedConversion = history
                    }
                  }
                }
            }
          }
        }
      }
      .listStyle(.insetGrouped)
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          withAnimation {
            appState.conversions.removeAll()
            Task {
              await PersistenceService().clearHistory()
            }
          }
        } label: {
          Image(systemName: "trash")
            .foregroundColor(.red)
        }
      }
    }
  }
  
  private var searchBar: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .foregroundColor(.secondary)
      
      TextField("Search conversions", text: $searchText)
        .textFieldStyle(.plain)
      
      if !searchText.isEmpty {
        Button {
          searchText = ""
        } label: {
          Image(systemName: "xmark.circle.fill")
            .foregroundColor(.secondary)
        }
      }
    }
    .padding(.horizontal)
    .padding(.vertical, 8)
    .background(Color(.systemBackground))
  }
}

struct HistoryItemView: View {
  let history: ConversionHistory
  
  var body: some View {
    VStack(spacing: 12) {
      HStack(alignment: .center) {
        // From amount
        VStack(alignment: .leading, spacing: 4) {
          Text(history.fromCurrency.rawValue)
            .font(.subheadline)
            .foregroundStyle(.secondary)
          Text(history.fromAmount.formattedPrice())
            .font(.title3)
            .fontWeight(.semibold)
        }
        
        Spacer()
        
        // Arrow
        Image(systemName: "arrow.right")
          .foregroundStyle(.secondary)
          .imageScale(.large)
        
        Spacer()
        
        // To amount
        VStack(alignment: .trailing, spacing: 4) {
          Text(history.toCurrency.rawValue)
            .font(.subheadline)
            .foregroundStyle(.secondary)
          Text(history.toAmount.formattedPrice())
            .font(.title3)
            .fontWeight(.semibold)
        }
      }
      
      Divider()
      
      HStack {
        // Exchange rate
        HStack(spacing: 4) {
          Image(systemName: "chart.line.uptrend.xyaxis")
            .imageScale(.small)
          Text("Rate: \(history.exchangeRate.formattedRate())")
        }
        .font(.caption)
        .foregroundStyle(.secondary)
        
        Spacer()
        
        // Time
        HStack(spacing: 4) {
          Image(systemName: "clock")
            .imageScale(.small)
          Text(formatTime(history.date))
        }
        .font(.caption)
        .foregroundStyle(.secondary)
      }
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 12)
        .fill(Color(.secondarySystemGroupedBackground))
    )
  }
  
  private func formatTime(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter.string(from: date)
  }
}

#Preview {
  NavigationStack {
    HistoryView()
      .navigationTitle("History")
  }
}
