//
//  NumberButton.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 18/11/2024.
//

import SwiftUI

struct NumberButton: View {
  let title: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Text(title)
        .font(.title)
        .frame(maxWidth: .infinity)
        .frame(height: Constants.NumberPad.buttonHeight)
        .background {
          RoundedRectangle(cornerRadius: Constants.Layout.cornerRadius)
            .fill(.ultraThinMaterial)
        }
    }
    .foregroundColor(.primary)
  }
}
