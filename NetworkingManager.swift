//
//  NetworkingManager.swift
//  
//
//  Created by Vítor Otero on 29/05/2023.
//

import Foundation
import Combine

class NetworkingManager {
    
    
//    private func getCoins() {
//        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h&locale=en") else {return}
//
//        coinSubscription = NetworkingManager.download(url: url)
//            .decode(type: [CoinModel].self, decoder: JSONDecoder())
//            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
//                        self?.allCoins = returnedCoins
//                        self?.coinSubscription?.cancel()
//            })
//    }
    
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
       return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
            
        }
    }
}

