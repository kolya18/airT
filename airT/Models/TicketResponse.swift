//
//  TicketResponse.swift
//  airT
//
//  Created by Николай Мартынов on 31.05.2024.
//

import Foundation

struct TicketAPIResponse: Decodable {
    let ticketsOffers: [TicketOffer]
    
    enum CodingKeys: String, CodingKey {
        case ticketsOffers = "tickets_offers"
    }
}
