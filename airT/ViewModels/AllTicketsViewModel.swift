//
//  AllTicketsViewModel.swift
//  airT
//
//  Created by Николай Мартынов on 31.05.2024.
//

import SwiftUI
import Combine

class AllTicketsViewModel: ObservableObject {
    @Published var cards: [Card] = []
    private var cancellables = Set<AnyCancellable>()

    func fetchData() {
        guard let url = URL(string: "https://run.mocky.io/v3/670c3d56-7f03-4237-9e34-d437a9e56ebf") else {
            print("Неверный URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .replaceError(with: APIResponse(tickets: []))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.cards = $0.tickets
            }
            .store(in: &cancellables)
    }
}
