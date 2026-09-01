	//
//  CryptoViewModel.swift
//  testSwiftUI
//
//  Created by Nikunj Rathod on 2025-08-21.
//


import Foundation
import SwiftUI
import RealmSwift
import Combine

class LocalCryptoViewModel: ObservableObject {
    @Published var cryptos: [Crypto] = []
    
    // We keep a reference to Realm to save/fetch later
    private var realm: Realm?

    init() {
        // Initialize Realm safely
        do {
            self.realm = try Realm()
        } catch {
            print("Error initializing Realm: \(error.localizedDescription)")
        }
        
        // Load the data immediately when the ViewModel is created
        loadLocalCrypto()
    }

    func loadLocalCrypto() {
        guard let url = Bundle.main.url(forResource: "Crypto", withExtension: "json") else {
            print("Crypto JSON not found")
            return
        }

        // Perform decoding on a background thread to keep the UI snappy
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                let decoded = try JSONDecoder().decode([Crypto].self, from: data)
                
                // Switch back to Main Thread to update @Published properties
                DispatchQueue.main.async {
                    self?.cryptos = decoded
                    print("Successfully loaded \(decoded.count) cryptos")
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error decoding crypto JSON: \(error)")
                }
            }
        }
    }
}
