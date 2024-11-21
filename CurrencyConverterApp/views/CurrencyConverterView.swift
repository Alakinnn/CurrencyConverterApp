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
    ZStack {
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
              currency: $vm.fromCurrency,
              onCurrencyChange: { _ in vm.convert() }
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
                Text("1 \(vm.fromCurrency.rawValue) = \(rate.formattedRate()) \(vm.toCurrency.rawValue)")
                  .font(.caption)
                  .foregroundColor(.white)
              }
            }
            
            currencySection(
              amount: vm.toAmount,
              currency: $vm.toCurrency,
              isEditable: false,
              onCurrencyChange: { _ in vm.convert() }
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
      
      // Overlays
      ZStack {
        if vm.isLoading {          
          ProgressView()
            .tint(.white)
            .scaleEffect(1.5)
        }
        
        if let error = vm.error {
          VStack {
            Spacer().frame(height: 60)
            
            Text(error)
              .foregroundColor(.white)
              .padding()
              .background(Color.red.opacity(0.8))
              .cornerRadius(Constants.Layout.cornerRadius)
              .shadow(radius: 5)
              .padding(.horizontal)
            
            Spacer()
          }
          .transition(.move(edge: .top).combined(with: .opacity))
        }
      }
      .animation(.easeInOut, value: vm.error)
      .animation(.easeInOut, value: vm.isLoading)
    }
  }
  
  private func currencySection(
    amount: String,
    currency: Binding<Currency>,
    isEditable: Bool = true,
    onCurrencyChange: @escaping (Currency) -> Void = { _ in }
  ) -> some View {
    VStack(alignment: .trailing, spacing: 8) {
      Menu {
        ForEach(Currency.allCases, id: \.self) { curr in
          Button(curr.rawValue) {
            currency.wrappedValue = curr
            onCurrencyChange(curr)
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
