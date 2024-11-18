//
//  CurrencyConverterView.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 18/11/2024.
//

import SwiftUI
struct CurrencyConverterView: View {
  @State private var fromAmount = ""
  @State private var toAmount = ""
  @State private var fromCurrency = Currency.usd
  @State private var toCurrency = Currency.eur
  
  var body: some View {
    VStack(spacing: 0) {
      ZStack {
        LinearGradient(
          gradient: Gradient(colors: [.mint.opacity(0.8), .cyan.opacity(0.6)]),
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        )
        
        VStack(spacing: 20) {
          currencySection(
            amount: $fromAmount,
            currency: $fromCurrency
          )
          
          HStack {
            Button {
            } label: {
              Image(systemName: "arrow.up.arrow.down")
                .font(.title2)
                .foregroundColor(.white)
            }
            
            Text("1 USD = 0.8525 EUR")  // TODO: Remove hardcoded block
              .font(.caption)
              .foregroundColor(.white)
          }
          
          currencySection(
            amount: $toAmount,
            currency: $toCurrency,
            isEditable: false
          )
          
          Button {
          } label: {
            Text("Convert")
              .font(.headline)
              .foregroundColor(.white)
              .frame(maxWidth: .infinity)
              .padding()
              .background(Color.blue.opacity(0.3))
              .cornerRadius(Constants.Layout.cornerRadius)
          }
        }
        .padding()
      }
      .frame(height: UIScreen.main.bounds.height * 0.4)
      
      numberPad
        .padding()
    }
  }
  
  private func currencySection(
    amount: Binding<String>,
    currency: Binding<Currency>,
    isEditable: Bool = true
  ) -> some View {
    VStack(alignment: .trailing, spacing: 8) {
      Menu {
        ForEach(Currency.allCases, id: \.self) { curr in
          Button(curr.rawValue) {
            currency.wrappedValue = curr
          }
        }
      } label: {
        HStack {
          Text(currency.wrappedValue.rawValue)
            .font(.headline)
          Image(systemName: "chevron.down")
        }
        .foregroundColor(.white)
      }
      
      Text(amount.wrappedValue.isEmpty ? "0" : amount.wrappedValue)
        .font(.system(size: 40, weight: .medium))
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
  }
  
  private var numberPad: some View {
    LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: Constants.NumberPad.spacing) {
      ForEach(1...9, id: \.self) { number in
        NumberButton(title: "\(number)") {
          if fromAmount.count < 10 {
            fromAmount += "\(number)"
          }
        }
      }
      
      NumberButton(title: "C") {
        fromAmount = ""
        toAmount = ""
      }
      
      NumberButton(title: "0") {
        if fromAmount.count < 10 {
          fromAmount += "0"
        }
      }
      
      NumberButton(title: ".") {
        if !fromAmount.contains(".") {
          fromAmount += fromAmount.isEmpty ? "0." : "."
        }
      }
    }
  }
}

#Preview {
  CurrencyConverterView()
}
