//
//  CurrencyConverterAppApp.swift
//  CurrencyConverterApp
//
//  Created by Duong Tran Minh Hoang on 17/11/2024.
//

import SwiftUI

@main
struct CurrencyConverterAppApp: App {
  @State private var appState = AppState.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environment(appState)
        }
    }
}
