//
//  SubscriptionsView.swift
//  airT
//
//  Created by Николай Мартынов on 29.05.2024.
//

import SwiftUI

struct SubscriptionsView: View {
    @ObservedObject var viewModel: SubscriptionsViewModel
    
    var body: some View {
        Text("Подписки")
            .font(.largeTitle)
            .padding()
    }
}

struct SubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionsView(viewModel: SubscriptionsViewModel())
    }
}
