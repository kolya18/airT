//
//  AllTicketsView.swift
//  airT
//
//  Created by Николай Мартынов on 31.05.2024.
//
import SwiftUI

struct AllTicketsView: View {
    @StateObject private var viewModel = AllTicketsViewModel()
    
    @Binding var from: String
    @Binding var to: String
    @Binding var isAllTickets: Bool
    @Binding var departureDate: Date
    
    var body: some View {
        VStack(spacing: 16)  {
            HStack {
                Button(action: {
                    isAllTickets = false
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.blue)
                    }
                    .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 5))
                    .frame(width: 24, height: 24)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(from + "-" + to)
                        .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                        .lineSpacing(19.20)
                        .foregroundColor(.white)
                    Text(dateFormatter.string(from: departureDate) + ", 1 пассажир")
                        .font(Font.custom("SF Pro Display", size: 14).weight(.medium))
                        .lineSpacing(16.80)
                        .foregroundColor(Color(red: 0.62, green: 0.62, blue: 0.62))
                }
                .frame(maxHeight: .infinity)
                Spacer()
            }
            .frame(width: 328, height: 56)
            .background(Color(red: 0.137, green: 0.15, blue: 0.16))
            .cornerRadius(8)
            .shadow(radius: 4)
            
            ZStack {
                ScrollView {
                    VStack(alignment: .center) {
                        ForEach(viewModel.cards) { card in
                            CardView(card: card)
                            Spacer(minLength: 26)
                        }
                    }
                    .padding()
                }
                
                VStack {
                    Spacer()
                    HStack(spacing: 16) {
                        Button(action: {
                            // Действие для фильтров
                        }) {
                            HStack(spacing: 4) {
                                HStack(spacing: 0) {
                                    Image(systemName: "slider.horizontal.3")
                                        .foregroundColor(.white)
                                }
                                .padding(EdgeInsets(top: 3, leading: 2, bottom: 2, trailing: 2))
                                .frame(width: 16, height: 16)
                                Text("Фильтр")
                                    .font(Font.custom("SF Pro Display", size: 14).weight(.medium))
                                    .lineSpacing(16.80)
                                    .foregroundColor(.white)
                            }}
                        Button(action: {
                            // Действие для графика цен
                        }) {
                            HStack(spacing: 4) {
                                HStack(spacing: 0) {
                                    Image(systemName: "chart.bar.xaxis")
                                        .foregroundColor(.white)
                                }
                                .padding(EdgeInsets(top: 2, leading: 1, bottom: 1, trailing: 1))
                                .frame(width: 16, height: 16)
                                Text("График цен")
                                    .font(Font.custom("SF Pro Display", size: 14).weight(.medium))
                                    .lineSpacing(16.80)
                                    .foregroundColor(.white)
                            }}
                    }
                    .padding(10)
                    .frame(width: 204, height: 37)
                    .background(Color(red: 0.14, green: 0.38, blue: 0.74))
                    .cornerRadius(50)
                }
                .padding(.bottom, 16)
            }
            .onAppear {
                viewModel.fetchData()
            }
        }
        .padding(.top, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

private var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM"
    formatter.locale = Locale(identifier: "ru_RU")
    return formatter
}

struct AllTicketsView_Previews: PreviewProvider {
    static var previews: some View {
        @State var from = "Москва"
        @State var to = "Турция"
        @State var departureDate = Date()
        @State var isAllTickets = true
        return AllTicketsView(
            from: $from,
            to: $to,
            isAllTickets: $isAllTickets,
            departureDate: $departureDate
        )
        .preferredColorScheme(.dark)
    }
}

