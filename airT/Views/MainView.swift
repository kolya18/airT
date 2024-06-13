//
//  MainView.swift
//  airT
//
//  Created by Николай Мартынов on 29.05.2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()
    @State private var from = UserDefaults.standard.string(forKey: "from") ?? ""
    @State private var to = UserDefaults.standard.string(forKey: "to") ?? ""
    @State private var isModalVisible = false
    @State private var isCountrySelected = false

    
    var body: some View {
        VStack {
            if isCountrySelected {
                CountrySelectedView(from: $from, to: $to, isCountrySelected: $isCountrySelected)
            } else {
                VStack(spacing: 20) {
                    // Заголовок
                    Text("Поиск дешевых\nавиабилетов")
                        .font(Font.custom("SF Pro Display", size: 22).weight(.semibold))
                        .lineSpacing(0)
                        .foregroundColor(Color.primary)
                        .padding(.top, 50)
                        .padding(.bottom, 20)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    
                    // Поле ввода места отправления
                    VStack(alignment: .leading, spacing: 10) {
                        ZStack {
                            HStack(spacing: 0) {
                              Image(systemName: "magnifyingglass")
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
                                    let filteredText = filterToCyrillic(newValue)
                                            if filteredText != newValue {
                                                from = filteredText
                                            }
                                    UserDefaults.standard.set(newValue, forKey: "from")
                                }
                            
                            Divider()
                                .background(Color.white)
                                .padding(.leading, 48.0)
                                .padding(.trailing, 20.0)
                            
                            HStack {
                                
                                TextField("Куда - Турция", text: $to, onEditingChanged: { isEditing in
                                    if isEditing {
                                        isModalVisible.toggle()
                                    }
                                })
                                .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                                .lineSpacing(20.80)
                                .foregroundColor(.white)
                                .offset(x: 48, y: 18.50)
                                .onChange(of: to) { newValue in
                                    let filteredText = filterToCyrillic(newValue)
                                            if filteredText != newValue {
                                                to = filteredText
                                            }
                                    if !newValue.isEmpty && !from.isEmpty {
                                        isCountrySelected = true
                                    }
                                }
                                
                                Spacer()
                            }
                        }
                        .frame(width: 296, height: 90)
                        .background(Color(red: 0.24, green: 0.25, blue: 0.26))
                        .cornerRadius(16)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)
                    }
                    .padding(16)
                    .frame(width: 328, height: 122)
                    .background(Color(red: 0.18, green: 0.19, blue: 0.21))
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .inset(by: 0.50)
                            .stroke(.black, lineWidth: 0.50)
                    )
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Музыкально отлететь")
                            .font(Font.custom("SF Pro Display", size: 22).weight(.semibold))
                            .lineSpacing(26.40)
                            .foregroundColor(Color.primary)
                            .multilineTextAlignment(.leading)
                            .background(Color(UIColor.systemBackground))
                            .padding(.leading, 20)
                        
                        // Лента с предложениями
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(viewModel.offers) { offer in
                                    OfferView(
                                        id: offer.id,
                                        title: offer.title,
                                        town: offer.town,
                                        price: offer.price.value
                                    )
                                }
                            }
                            .padding()
                        }
                    }
                    Spacer()
                }
                .padding()
                .sheet(isPresented: $isModalVisible) {
                    ModalView(from: $from, to: $to, isModalVisible: $isModalVisible).preferredColorScheme(.dark)
                }
            }
        }
    }

}


struct ModalView: View {
    @Binding var from: String
    @Binding var to: String
    @Binding var isModalVisible: Bool
    @State private var isPlaceholderVisible = false
    @State private var isHolidayVisible = false
    @State private var isHotTicketVisible = false
    var body: some View {
        VStack(spacing: 20) {
            
            Capsule().frame(width: 40, height: 6)
                            .foregroundColor(Color.gray.opacity(0.6))
                            .padding(.top, 8)
            
            // Поля ввода в модальном окне
            VStack(alignment: .leading, spacing: 10) {
                ZStack {
                    HStack(spacing: 0) {
                        VStack(spacing: 20) {
                            Image(systemName: "airplane").colorMultiply(.gray)
                            
                            Image(systemName: "magnifyingglass")
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
                    
                    Divider()
                                        .background(Color.gray)
                                        .padding(.horizontal, 10)
                    
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
            .padding(16)
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)
            
            //Быстрые кнопки
            HStack(alignment: .top, spacing: 16) {
                VStack(spacing: 8) {
                    Button(action: {
                        // Действие для кнопки "Сложный маршрут"
                        isPlaceholderVisible = true
                    }) {
                        HStack(spacing: 0) {
                            Image("m1")
                                .padding(2)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .padding(12)
                        .frame(width: 48, height: 48)
                        .background(Color(red: 0.23, green: 0.39, blue: 0.23))
                        .cornerRadius(8)
                    }
                    Text("Сложный маршрут")
                        .font(Font.custom("SF Pro Display", size: 14))
                        .lineSpacing(4)
                        .foregroundColor(.white)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                }
                VStack(spacing: 8) {
                    Button(action: {
                        // Действие для кнопки "Куда угодно"
                        to = "Куда угодно"
                    }) {
                        HStack(spacing: 0) {
                            Image("m2")
                                .frame(width: 24, height: 24)
                        }
                        .padding(12)
                        .frame(width: 48, height: 48)
                        .background(Color(red: 0.14, green: 0.38, blue: 0.74))
                        .cornerRadius(8)
                    }
                    Text("Куда угодно")
                        .font(Font.custom("SF Pro Display", size: 14))
                        .lineSpacing(4)
                        .foregroundColor(.white)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                }
                VStack(spacing: 8) {
                    Button(action: {
                        // Действие для кнопки "Выходные"
                        isHolidayVisible = true
                    }) {
                        HStack(spacing: 0) {
                            Image("m3")
                                .frame(width: 24, height: 24)
                        }
                        .padding(12)
                        .frame(width: 48, height: 48)
                        .background(Color(red: 0, green: 0.26, blue: 0.49))
                        .cornerRadius(8)
                    }
                    Text("Выходные")
                        .font(Font.custom("SF Pro Display", size: 14))
                        .lineSpacing(4)
                        .foregroundColor(.white)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                }
                VStack(spacing: 8) {
                    Button(action: {
                        // Действие для кнопки "Горячие билеты"
                        isHotTicketVisible = true
                    }) {
                        HStack(spacing: 0) {
                            Image("m4")
                                .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .padding(12)
                        .frame(width: 48, height: 48)
                        .background(Color(red: 1, green: 0.37, blue: 0.37))
                        .cornerRadius(8)
                    }
                    Text("Горячие билеты")
                        .font(Font.custom("SF Pro Display", size: 14))
                        .lineSpacing(4)
                        .foregroundColor(.white)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(width: 326, height: 90)

            // Популярные направления
            VStack(alignment: .center, spacing: 8) {
                // Кнопка для Стамбула
                Button(action: {
                    // Действие для кнопки
                    to = "Стамбул"
                    //isModalVisible = false
                    
                }) {
                    HStack(alignment: .center, spacing: 8) {
                        Image("Stambul")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Стамбул")
                                .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                                .foregroundColor(.white)
                            Text("Популярное направление")
                                .font(Font.custom("SF Pro Display", size: 14))
                                .foregroundColor(Color(red: 0.37, green: 0.37, blue: 0.38))
                        }
                        
                    }
                    .padding(.trailing, 46)
                    .frame(width: 296, height: 56)
                }
                .buttonStyle(PlainButtonStyle())
                
                // Разделительная линия
                Rectangle()
                    .foregroundColor(Color(red: 0.24, green: 0.25, blue: 0.26))
                    .frame(height: 1)
                
                // Кнопка для Сочи
                Button(action: {
                    // Действие для кнопки
                    to = "Сочи"
                }) {
                    HStack(alignment: .center, spacing: 8) {
                        Image("Sochi")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Сочи")
                                .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                                .foregroundColor(.white)
                            Text("Популярное направление")
                                .font(Font.custom("SF Pro Display", size: 14))
                                .foregroundColor(Color(red: 0.37, green: 0.37, blue: 0.38))
                        }
                        
                    }
                    .padding(.trailing, 46)
                    .frame(width: 296, height: 56)
                }
                .buttonStyle(PlainButtonStyle())
                
                // Разделительная линия
                Rectangle()
                    .foregroundColor(Color(red: 0.24, green: 0.25, blue: 0.26))
                    .frame(height: 1)
                
                // Кнопка для Пхукета
                Button(action: {
                    // Действие для кнопки
                    to = "Пхукет"
                }) {
                    HStack(alignment: .center, spacing: 8) {
                        Image("Phuket")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Пхукет")
                                .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                                .foregroundColor(.white)
                            Text("Популярное направление")
                                .font(Font.custom("SF Pro Display", size: 14))
                                .foregroundColor(Color(red: 0.37, green: 0.37, blue: 0.38))
                        }
                        
                    }
                    .padding(.trailing, 46)
                    .frame(width: 296, height: 56)
                }
                .buttonStyle(PlainButtonStyle())
                
                // Разделительная линия
                Rectangle()
                    .foregroundColor(Color(red: 0.24, green: 0.25, blue: 0.26))
                    .frame(height: 1)
            }
            .padding(16)
            .frame(width: 296, height: 226)
            .background(Color(red: 0.18, green: 0.19, blue: 0.21))
            .cornerRadius(16)

            
            
            //Кнопка закрыть
            
//            Button(action: {
//                isModalVisible = false
//            }) {
//                Text("Закрыть")
//                    .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
            
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .fullScreenCover(isPresented: $isPlaceholderVisible) {
                    PlaceholderView(isVisible: $isPlaceholderVisible)
                }
        .fullScreenCover(isPresented: $isHolidayVisible) {
                    HolidayView(isVisible: $isHolidayVisible)
                }
        .fullScreenCover(isPresented: $isHotTicketVisible) {
                    HotTicketView(isVisible: $isHotTicketVisible)
                }
    }
}

struct OfferView: View {
    let id: Int
    let title: String
    let town: String
    let price: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image("offer\(id)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 132, height: 133.16)
                .cornerRadius(16)
            
            Text(title)
                .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
            
            Text(town)
                .font(Font.custom("SF Pro Display", size: 14))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
            
            HStack {
                Image(systemName: "airplane")
                Text("от \(formattedPrice(price)) ₽")
                    .font(Font.custom("SF Pro Display", size: 14))
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.black)
        .cornerRadius(16)
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)
        
    }
    
    private func formattedPrice(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().preferredColorScheme(.dark)
    }
}

func filterToCyrillic(_ text: String) -> String {
    let cyrillicCharacterSet = CharacterSet(charactersIn: "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя")
    return text.filter { char in
        String(char).rangeOfCharacter(from: cyrillicCharacterSet) != nil
    }
}
