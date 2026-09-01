//
//  CryptoViewModel.swift
//  testSwiftUI
//
//  Created by Nikunj Rathod on 2025-08-24.
//

import SwiftUI
import RealmSwift
import Combine

class CryptoViewModel: ObservableObject {
    @Published var cryptos: [Crypto] = []
    // Use the Realm 'Results' type for live-updating data
    @Published var watchlist: [WatchlistCrypto] = []

    private var realm: Realm?

    init() {
        do {
            self.realm = try Realm()
            loadLocalCrypto()
            loadWatchlist()
        } catch {
            print("Error initializing Realm: \(error.localizedDescription)")
        }
    }

    func loadLocalCrypto() {
        guard let url = Bundle.main.url(forResource: "Crypto", withExtension: "json") else {
            print("JSON file not found")
            return
        }
        
        // Use background thread for decoding if the JSON is large
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let data = try Data(contentsOf: url)
                let decoded = try JSONDecoder().decode([Crypto].self, from: data)
                DispatchQueue.main.async {
                    self.cryptos = decoded
                }
            } catch {
                print("Error decoding crypto JSON: \(error)")
            }
        }
    }

    func addToWatchlist(crypto: Crypto) {
        guard let realm = realm else { return }
        
        let item = WatchlistCrypto()
        item.symbol = crypto.symbol
        item.name = crypto.name
        item.price = crypto.price

        try? realm.write {
            // .modified ensures we don't get duplicates if the primary key exists
            realm.add(item, update: .modified)
        }
        loadWatchlist()
    }

    func loadWatchlist() {
        guard let realm = realm else { return }
        let results = realm.objects(WatchlistCrypto.self)
        // Convert to Array for the @Published property
        self.watchlist = Array(results)
    }

    func removeFromWatchlist(symbol: String) {
        guard let realm = realm else { return }

        if let item = realm.object(ofType: WatchlistCrypto.self, forPrimaryKey: symbol) {
            do {
                try realm.write {
                    realm.delete(item)
                }
                loadWatchlist()
            } catch {
                print("Could not delete item: \(error)")
            }
        }
    }

    func isInWatchlist(symbol: String) -> Bool {
        return realm?.object(ofType: WatchlistCrypto.self, forPrimaryKey: symbol) != nil
    }
}
