//
//  PlaceholderView.swift
//  airT
//
//  Created by Николай Мартынов on 30.05.2024.
//

import SwiftUI

struct PlaceholderView: View {
    @Binding var isVisible: Bool
    
    var body: some View {
        VStack {
            Text("Сложный маршрут")
                .font(Font.custom("SF Pro Display", size: 22).weight(.semibold))
                .foregroundColor(.white)
                .padding(.bottom, 20)
            
            Button(action: {
                isVisible = false
            }) {
                Text("Закрыть")
                    .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.8))
        .cornerRadius(16)
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)
    }
}
