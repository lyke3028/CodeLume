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
        // 初始化日志
        _ = Logger.shared
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
