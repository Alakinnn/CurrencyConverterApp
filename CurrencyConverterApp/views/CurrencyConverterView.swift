//
//  CurrencyConverterView.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 18/11/2024.
//

import SwiftUI
struct CurrencyConverterView: View {
  @State var vm: CurrencyConverterViewModel
  
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
            amount: vm.fromAmount,
            currency: $vm.fromCurrency
          )
          
          HStack {
            Button {
              vm.swapCurrencies()
            } label: {
              Image(systemName: "arrow.up.arrow.down")
                .font(.title2)
                .foregroundColor(.white)
            }
            
            if let rate = vm.currentRate {
              Text("1 \(vm.fromCurrency.rawValue) = \(String(format: "%.4f", rate)) \(vm.toCurrency.rawValue)")
                .font(.caption)
                .foregroundColor(.white)
            }
          }
          
          currencySection(
            amount: vm.toAmount,
            currency: $vm.toCurrency,
            isEditable: false
          )
          
          Button {
            vm.convert()
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
      .ignoresSafeArea()
      
      numberPad
        .padding()
    }
  }
  
  private func currencySection(
    amount: String,
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
      
      Text(amount.isEmpty ? "0" : amount)
        .font(.system(size: 40, weight: .medium))
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
  }
  
  private var numberPad: some View {
    LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: Constants.NumberPad.spacing) {
      ForEach(1...9, id: \.self) { number in
        NumberButton(title: "\(number)") {
          vm.numberPressed(number)
        }
      }
      
      NumberButton(title: "C") {
        vm.clearPressed()
      }
      
      NumberButton(title: "0") {
        vm.numberPressed(0)
      }
      
      NumberButton(title: ".") {
        vm.decimalPressed()
      }
    }
  }
}
