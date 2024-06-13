//
//  Card.swift
//  airT
//
//  Created by Николай Мартынов on 31.05.2024.
//

import Foundation

struct Card: Identifiable, Decodable {
    let id = UUID()
    let badge: String?
    let price: Price
    let departure: FlightInfo
    let arrival: FlightInfo
    let hasTransfer: Bool

    enum CodingKeys: String, CodingKey {
        case badge
        case price
        case departure
        case arrival
        case hasTransfer = "has_transfer"
    }

    struct Price: Decodable {
        let value: Double
    }
}

struct FlightInfo: Decodable {
    let date: String
    let airport: String
}

struct APIResponse: Decodable {
    let tickets: [Card]
}

