//
//  airTApp.swift
//  airT
//
//  Created by Николай Мартынов on 29.05.2024.
//

import SwiftUI

@main
struct airTApp: App {
    @StateObject private var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            ContentView(coordinator: coordinator).preferredColorScheme(.dark)
        }
    }
}
