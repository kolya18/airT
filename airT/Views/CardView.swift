//
//  CardView.swift
//  airT
//
//  Created by Николай Мартынов on 31.05.2024.
//

import SwiftUI



struct CardView: View {
    let card: Card
    
    var body: some View {
        
            VStack(alignment: .leading, spacing: 0) {
                if let badge = card.badge {
                    HStack(spacing: 8) {
                        Text(badge)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                    .background(Color(red: 0.14, green: 0.38, blue: 0.74))
                    .cornerRadius(50)
                    .offset(x: 0, y: 10) // Измененный offset для badge
                    .zIndex(1) // Устанавливаем zIndex для переднего плана
                }
                ZStack {
                    Text("\(card.price.value, specifier: "%.0f") ₽")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                        .offset(x: -108.50, y: -24.50)
                    HStack(spacing: 8) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 24, height: 24)
                            .background(Color.red)
                            .cornerRadius(50)
                        //
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(formattedTime(from: card.departure.date))
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                            + Text(" - ")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                            + Text(formattedTime(from: card.arrival.date))
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                            
                            Text(card.departure.airport)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color.gray)
                            + Text("     ")
                                .font(.system(size: 14, weight: .medium))
                            + Text(card.arrival.airport)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color.gray)
                            
                        }
                        .offset(x: 0, y: 0)
                        
                    }
                    .offset(x: -87.50, y: 23.50)
                    Text("\(flightDuration(from: card.departure.date, to: card.arrival.date)) \(card.hasTransfer ? "" : "/Без пересадок")")
                        .font(.system(size: 13))
                        .foregroundColor(.white)
                        .offset(x: 68.50, y: 13)
                    
                }
                .frame(width: 328, height: 117)
                .background(Color(red: 0.137, green: 0.15, blue: 0.16))
                .cornerRadius(8)
            }
            .frame(width: 328, height: 117)
        
    }
    

    private func formattedTime(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "HH:mm"
            return outputFormatter.string(from: date)
        }
        
        return dateString
    }

    private func flightDuration(from departure: String, to arrival: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        guard let departureDate = dateFormatter.date(from: departure),
              let arrivalDate = dateFormatter.date(from: arrival) else { return "" }

        let duration = arrivalDate.timeIntervalSince(departureDate)
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60

        return "\(hours).\(minutes)ч в пути"
    }

}

