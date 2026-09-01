//
//  PolygonAPIService.swift
//  testSwiftUI
//
//  Created by Nikunj Rathod on 2025-08-20.
//


import Foundation

class PolygonAPIService {
    func fetchTop100Stocks(completion: @escaping ([Ticker]) -> Void) {
        let urlString = "\(Constants.baseURL)?market=stocks&active=true&limit=100&order=desc&apiKey=\(Constants.apiKey)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }

            do {
                print(urlString)
                let response = try JSONDecoder().decode(TickerResponse.self, from: data)
                completion(response.results)
            } catch {
                print("Decoding error: \(error)")
                completion([])
            }
        }.resume()
    }
}

struct TickerResponse: Decodable {
    let results: [Ticker]
}
