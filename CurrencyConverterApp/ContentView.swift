//
//  ContentView.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 17/11/2024.
//

import SwiftUI

struct ContentView: View {
  @State private var ccVm = CurrencyConverterViewModel()
  @Bindable private var appState = AppState.shared
  
    var body: some View {
      TabView(selection: $appState.selectedTab) {
        NavigationStack {
          CurrencyConverterView(vm: ccVm)
        }
        .tag(0)
        .tabItem {
        Label("Convert", systemImage: "arrow.left.arrow.right")
        }
        
        NavigationStack {
          HistoryView()
            .navigationTitle("History")
        }
        .tag(1)
        .tabItem {
          Label("History", systemImage: "clock")
        }
      }
    }
}

#Preview {
    ContentView()
}
