//
//  HotelsView.swift
//  airT
//
//  Created by Николай Мартынов on 29.05.2024.
//

import SwiftUI

struct HotelsView: View {
    @ObservedObject var viewModel: HotelsViewModel
    
    var body: some View {
        Text("Отели")
            .font(.largeTitle)
            .padding()
    }
}

struct HotelsView_Previews: PreviewProvider {
    static var previews: some View {
        HotelsView(viewModel: HotelsViewModel())
    }
}
