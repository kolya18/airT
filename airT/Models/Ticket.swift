//
//  Ticket.swift
//  airT
//
//  Created by Николай Мартынов on 31.05.2024.
//

import Foundation

struct TicketOffer: Decodable {
    let title: String
    let price: TicketPrice
    let timeRange: [String]
    
    enum CodingKeys: String, CodingKey {
        case title
        case price
        case timeRange = "time_range"
    }
}

struct TicketPrice: Decodable {
    let value: Double
}
