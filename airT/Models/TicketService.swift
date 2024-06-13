//
//  TicketService.swift
//  airT
//
//  Created by Николай Мартынов on 31.05.2024.
//

import Foundation
import Combine

class TicketService {
    static func fetchTicketOffers() -> AnyPublisher<[TicketOffer], Error> {
        guard let url = URL(string: "https://run.mocky.io/v3/7e55bf02-89ff-4847-9eb7-7d83ef884017") else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: TicketAPIResponse.self, decoder: JSONDecoder())
            .map { Array($0.ticketsOffers.prefix(3)) }
            .eraseToAnyPublisher()
    }
}

