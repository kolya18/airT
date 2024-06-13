//
//  Offer.swift
//  airT
//
//  Created by Николай Мартынов on 29.05.2024.
//

import Foundation

struct Offer: Identifiable, Decodable {
    let id: Int
    let title: String
    let town: String
    let price: Price
}

struct Price: Decodable {
    let value: Int
}

struct OfferResponse: Decodable {
    let offers: [Offer]
}



