//
//  APIService.swift
//  airT
//
//  Created by Николай Мартынов on 29.05.2024.
//

import Foundation
import Combine

class APIService {
    static let shared = APIService()
    
    func fetchOffers() -> AnyPublisher<[Offer], Error> {
        let url = URL(string: "https://run.mocky.io/v3/214a1713-bac0-4853-907c-a1dfc3cd05fd")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: OfferResponse.self, decoder: JSONDecoder())
            .map { $0.offers } // Извлекаем массив предложений из обертки
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}
