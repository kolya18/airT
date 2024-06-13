//
//  MainViewModel.swift
//  airT
//
//  Created by Николай Мартынов on 29.05.2024.
//

import Combine
import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var offers: [Offer] = []
    @Published var departure: String = "Москва"
    @Published var destination: String = "Турция"
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchOffers()
    }
    
    func fetchOffers() {
        APIService.shared.fetchOffers()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Ошибка при загрузке предложений: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { offers in
                self.offers = offers
                self.printOffersToConsole(offers: offers) // Печать предложений в консоль
            })
            .store(in: &cancellables)
    }
    
    private func printOffersToConsole(offers: [Offer]) {
        for offer in offers {
            print("ID: \(offer.id), Title: \(offer.title), Town: \(offer.town), Price: \(offer.price.value)")
        }
    }
}





