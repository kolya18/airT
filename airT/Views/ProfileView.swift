//
//  ProfileView.swift
//  airT
//
//  Created by Николай Мартынов on 29.05.2024.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        Text("Профиль")
            .font(.largeTitle)
            .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel())
    }
}
