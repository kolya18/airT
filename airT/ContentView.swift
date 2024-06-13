//
//  ContentView.swift
//  airT
//
//  Created by Николай Мартынов on 29.05.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        TabView {
            coordinator.currentView
                .tabItem {
                    Image(systemName: "airplane")
                    Text("Авиабилеты")
                }
                .onTapGesture {
                    coordinator.showMain()
                }
            
            HotelsView(viewModel: HotelsViewModel())
                .tabItem {
                    Image(systemName: "bed.double.fill")
                    Text("Отели")
                }
                .onTapGesture {
                    coordinator.showHotels()
                }
            
            ShortcutsView(viewModel: ShortcutsViewModel())
                .tabItem {
                    Image("Vector")
                    Text("Короче")
                }
                .onTapGesture {
                    coordinator.showShortcuts()
                }
            
            SubscriptionsView(viewModel: SubscriptionsViewModel())
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("Подписки")
                }
                .onTapGesture {
                    coordinator.showSubscriptions()
                }
            
            ProfileView(viewModel: ProfileViewModel())
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Профиль")
                }
                .onTapGesture {
                    coordinator.showProfile()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coordinator: AppCoordinator())
    }
}


