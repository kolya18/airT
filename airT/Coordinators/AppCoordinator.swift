//
//  AppCoordinator.swift
//  airT
//
//  Created by Николай Мартынов on 29.05.2024.
//

import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var currentView: AnyView = AnyView(MainView(viewModel: MainViewModel()))
    
    func showMain() {
        currentView = AnyView(MainView(viewModel: MainViewModel()))
    }
    
    func showHotels() {
        currentView = AnyView(HotelsView(viewModel: HotelsViewModel()))
    }
    
    func showShortcuts() {
        currentView = AnyView(ShortcutsView(viewModel: ShortcutsViewModel()))
    }
    
    func showSubscriptions() {
        currentView = AnyView(SubscriptionsView(viewModel: SubscriptionsViewModel()))
    }
    
    func showProfile() {
        currentView = AnyView(ProfileView(viewModel: ProfileViewModel()))
    }
}
