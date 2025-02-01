//
//  HeadwayApp.swift
//  Headway
//
//  Created by omar abozeid on 01/02/2025.
//

import SwiftUI

@main
struct HeadwayApp: App {
    @StateObject private var languageManager = LanguageManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.layoutDirection, languageManager.isRTL ? .rightToLeft : .leftToRight)
                .environmentObject(languageManager)
        }
    }
}
