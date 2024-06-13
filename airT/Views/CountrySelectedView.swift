//
//  CountrySelectedView.swift
//  airT
//
//  Created by Николай Мартынов on 30.05.2024.
//

import SwiftUI
import Combine

struct CountrySelectedView: View {
    @Binding var from: String
    @Binding var to: String
    @Binding var isCountrySelected: Bool
    
    @State private var departureDate = Date()
    @State private var returnDate: Date? = nil
    @State private var isDepartureDatePickerPresented = false
    @State private var isReturnDatePickerPresented = false
    @State private var isAllTickets = false
    @State private var ticketOffers: [TicketOffer] = []
    @State private var cancellable: AnyCancellable?

    var body: some View {
        VStack {
            if isAllTickets {
                AllTicketsView(from: $from, to: $to, isAllTickets: $isAllTickets, departureDate: $departureDate)
            } else {
                //Поля ввода
                VStack(alignment: .leading, spacing: 10) {
                    ZStack {
                        HStack(spacing: 0) {
                            VStack(spacing: 20) {
                                Button(action: {
                                    isCountrySelected = false
                                }) {
                                    Image(systemName: "arrow.left")
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .padding(4)
                        .frame(width: 24, height: 24)
                        .offset(x: -128, y: 0)
                        
                        
                        TextField("Откуда - Москва", text: $from)
                            .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                            .lineSpacing(20.80)
                            .foregroundColor(.white)
                            .offset(x: 48, y: -18.50)
                            .onChange(of: from) { newValue in
                                UserDefaults.standard.set(newValue, forKey: "from")
                            }
                        
                        Button(action: {
                            let temp = from
                            from = to
                            to = temp
                        }) {
                            Image(systemName: "arrow.up.arrow.down")
                                .foregroundColor(.white)
                        }
                        .offset(x: 120, y: -20)
                        
                        
                        Divider()
                            .background(Color.gray)
                            .padding(.leading, 48)
                            .padding(.trailing, 10.0)
                        
                        HStack {
                            TextField("Куда - Турция", text: $to)
                                .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                                .lineSpacing(20.80)
                                .foregroundColor(.white)
                                .offset(x: 48, y: 18.50)
                            
                            Spacer()
                            
                            Button(action: {
                                to = ""
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                            }
                            .offset(x: -20, y: 18.50)
                        }
                    }
                    .frame(width: 296, height: 90)
                    .background(Color(red: 0.24, green: 0.25, blue: 0.26))
                    .cornerRadius(16)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)
                    
                }
                .padding(0)
                .cornerRadius(16)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)
                
                //Кнопки
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 8) {
                        Button(action: {
                            isReturnDatePickerPresented.toggle()
                        }) {
                            HStack(spacing: 8) {
                                HStack(spacing: 0) {
                                    Image(systemName: returnDate == nil ? "plus" : "calendar")
                                        .foregroundColor(.white)
                                }
                                .padding(EdgeInsets(top: 2, leading: 2, bottom: 1.27, trailing: 1.27))
                                .frame(width: 16, height: 16)
                                Text(returnDate == nil ? "обратно" : dateFormatter.string(from: returnDate!))
                                    .font(Font.custom("SF Pro Display", size: 14).weight(.medium))
                                    .lineSpacing(16.80)
                                    .foregroundColor(.white)
                            }
                            .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                            .background(Color(red: 0.18, green: 0.19, blue: 0.21))
                            .cornerRadius(50)
                        }
                        .sheet(isPresented: $isReturnDatePickerPresented) {
                            VStack {
                                DatePicker("Выберите дату", selection: Binding(
                                    get: { returnDate ?? Date() },
                                    set: { returnDate = $0 }
                                ), displayedComponents: .date)
                                .datePickerStyle(GraphicalDatePickerStyle())
                                .padding()
                                Button("Применить") {
                                    isReturnDatePickerPresented = false
                                }
                                .padding()
                            }
                        }
                        
                        Button(action: {
                            isDepartureDatePickerPresented.toggle()
                        }) {
                            HStack(spacing: 8) {
                                Text(dateFormatter.string(from: departureDate))
                                    .font(Font.custom("SF Pro Display", size: 14).weight(.medium))
                                    .lineSpacing(16.80)
                                    .foregroundColor(.white)
                            }
                            .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                            .background(Color(red: 0.18, green: 0.19, blue: 0.21))
                            .cornerRadius(50)
                        }
                        .sheet(isPresented: $isDepartureDatePickerPresented) {
                            VStack {
                                DatePicker("Выберите дату", selection: $departureDate, displayedComponents: .date)
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                    .padding()
                                Button("Применить") {
                                    isDepartureDatePickerPresented = false
                                }
                                .padding()
                            }
                        }
                        
                        Button(action: {
                            // Действие для числа пассажиров и класса
                        }) {
                            HStack(spacing: 8) {
                                HStack(spacing: 0) {
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.white)
                                }
                                .padding(3)
                                .frame(width: 16, height: 16)
                                Text("1,эконом")
                                    .font(Font.custom("SF Pro Display", size: 14).weight(.medium))
                                    .lineSpacing(16.80)
                                    .foregroundColor(.white)
                            }
                            .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                            .background(Color(red: 0.18, green: 0.19, blue: 0.21))
                            .cornerRadius(50)
                        }
                        
                        Button(action: {
                            // Действие для фильтров
                        }) {
                            HStack(spacing: 8) {
                                HStack(spacing: 0) {
                                    Image(systemName: "slider.horizontal.3")
                                        .foregroundColor(.white)
                                }
                                .padding(EdgeInsets(top: 3, leading: 2, bottom: 2, trailing: 2))
                                .frame(width: 16, height: 16)
                                Text("фильтры")
                                    .font(Font.custom("SF Pro Display", size: 14).weight(.medium))
                                    .lineSpacing(16.80)
                                    .foregroundColor(.white)
                            }
                            .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                            .frame(height: 33)
                            .background(Color(red: 0.18, green: 0.19, blue: 0.21))
                            .cornerRadius(50)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.leading)
                .frame(height: 33)
                //

                // Прямые рейсы
                VStack(alignment: .leading, spacing: 8) {
                    Text("Прямые рейсы")
                        .font(Font.custom("SF Pro Display", size: 20).weight(.semibold))
                        .lineSpacing(24)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ForEach(ticketOffers.indices, id: \.self) { index in
                        let offer = ticketOffers[index]
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(alignment: .center, spacing: 8) {
                                Circle()
                                    .fill(circleColor(for: index))
                                    .frame(width: 24, height: 24)

                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text(offer.title)
                                            .font(Font.custom("SF Pro Display", size: 14).weight(.medium))
                                            .lineSpacing(16.80)
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Spacer()
                                        Button(action: {
                                        // Действие при нажатии на кнопку
                                        }) {
                                            Text("\(formatPrice(offer.price.value)) ₽ ⟩")
                                                .font(Font.custom("SF Pro Display", size: 14).weight(.medium))
                                                .lineSpacing(16.80)
                                                .foregroundColor(.blue)
                                        }
                                    }
                                    Text(offer.timeRange.joined(separator: " "))
                                        .font(Font.custom("SF Pro Display", size: 14))
                                        .lineSpacing(16.80)
                                        .foregroundColor(.white)
                                }
                            }
                            .frame(height: 56)
                            .frame(maxWidth: .infinity, alignment: .leading)

                            // Разделительная линия
                            Rectangle()
                                .foregroundColor(Color(red: 0.24, green: 0.25, blue: 0.26))
                                .frame(height: 1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    Spacer()
                    // Остальной код
                    
                }
                .padding(20)
                .frame(width: 296, height: 290)
                .background(Color(red: 0.18, green: 0.19, blue: 0.21))
                .cornerRadius(16)
                .frame(maxWidth: .infinity, alignment: .center)
                
                // Кнопка "Посмотреть все билеты"
                Button(action: {
                    isAllTickets = true
                }) {
                    Text("Посмотреть все билеты")
                        .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                        .lineSpacing(20.80)
                        .foregroundColor(.white)
                        .frame(width: 296, height: 42)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(18)
                
                // Подписка на цену - нефункциональный элемент
                HStack {
                    HStack {
                        HStack {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.blue)
                                .padding(4)
                        }
                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2.50, trailing: 4.83))
                        .frame(width: 24, height: 24)
                        Text("Подписка на цену")
                            .font(Font.custom("SF Pro Display", size: 13))
                            .foregroundColor(.white)
                            .lineLimit(2)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    VStack {
                        Toggle(isOn: .constant(false)) {
                            Text("")
                        }
                        .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 16, bottom: 11, trailing: 10))
                .frame(width: 296, height: 51)
                .background(Color(red: 0.14, green: 0.15, blue: 0.16))
                .cornerRadius(8)
                
                Spacer()
            }
        }
        .padding()
        .onAppear {
            cancellable = TicketService.fetchTicketOffers()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print("Error fetching data: \(error)")
                    }
                }, receiveValue: { offers in
                    self.ticketOffers = offers
                })
        }
        .onDisappear {
            cancellable?.cancel()
        }
    }

        
    private func formatPrice(_ price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter.string(for: price) ?? "\(price)"
    }
    
    private func circleColor(for index: Int) -> Color {
        switch index % 3 {
        case 0:
            return .red
        case 1:
            return .blue
        case 2:
            return .white
        default:
            return .clear
        }
    }
    
}

private var dateFormatter: DateFormatter {
     let formatter = DateFormatter()
     formatter.dateFormat = "dd MMM, E"
     formatter.locale = Locale(identifier: "ru_RU")
     return formatter
 }


// Просмотр
struct CountrySelectedView_Previews: PreviewProvider {
    static var previews: some View {
        // Пример использования State для предпросмотра
        @State var from = "Москва"
        @State var to = "Турция"
        @State var isCountrySelected = true

        return CountrySelectedView(
            from: $from,
            to: $to,
            isCountrySelected: $isCountrySelected
        )
        .preferredColorScheme(.dark)
    }
}

