//
//  CodeLumeApp.swift
//  CodeLume
//
//  Created by Lyke on 2025/3/13.
//

import SwiftUI

@main
struct CodeLumeApp: App {
    init() {
        _ = Logger.shared
        
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    let theme = UserDefaults.standard.string(forKey: "AppleInterfaceStyle")
                    switch theme {
                    case "Light":
                        NSApp.appearance = NSAppearance(named: .aqua)
                    case "Dark":
                        NSApp.appearance = NSAppearance(named: .darkAqua)
                    default:
                        NSApp.appearance = nil
                    }
                }
        }
        
        Settings {
            SettingsView()
        }
    }
}
