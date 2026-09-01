	//
//  CryptoViewModel.swift
//  testSwiftUI
//
//  Created by Nikunj Rathod on 2025-08-21.
//


import Foundation

class LocalCryptoViewModel: ObservableObject {
    @Published var cryptos: [Crypto] = []

    func loadLocalCrypto() {
        guard let url = Bundle.main.url(forResource: "Crypto", withExtension: "json") else {
            print("Crypto JSON not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Crypto].self, from: data)
            self.cryptos = decoded
        } catch {
            print("Error decoding crypto JSON: \(error)")
        }
    }
}
