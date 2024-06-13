//
//  ShortcutsView.swift
//  airT
//
//  Created by Николай Мартынов on 29.05.2024.
//

import SwiftUI

struct ShortcutsView: View {
    @ObservedObject var viewModel: ShortcutsViewModel
    
    var body: some View {
        Text("Короче")
            .font(.largeTitle)
            .padding()
    }
}

struct ShortcutsView_Previews: PreviewProvider {
    static var previews: some View {
        ShortcutsView(viewModel: ShortcutsViewModel())
    }
}
