//
//  CryptoViewModel.swift
//  testSwiftUI
//
//  Created by Nikunj Rathod on 2025-08-24.
//

import SwiftUI
import RealmSwift

class CryptoViewModel: ObservableObject {
    @Published var cryptos: [Crypto] = []
    @Published var watchlist: [WatchlistCrypto] = []

    private var realm = try! Realm()

    func loadLocalCrypto() {
        guard let url = Bundle.main.url(forResource: "Crypto", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Crypto].self, from: data)
            self.cryptos = decoded
        } catch {
            print("Error decoding crypto JSON: \(error)")
        }
    }

    func addToWatchlist(crypto: Crypto) {
        let item = WatchlistCrypto()
        item.symbol = crypto.symbol
        item.name = crypto.name
        item.price = crypto.price

        try? realm.write {
            realm.add(item, update: .modified)
        }
        loadWatchlist()
    }

    func loadWatchlist() {
        let results = realm.objects(WatchlistCrypto.self)
        self.watchlist = Array(results)
    }

    func removeFromWatchlist(symbol: String) {
        let realm = try! Realm()

        // ✅ Always re-fetch the object from the current Realm instance
        if let item = realm.object(ofType: WatchlistCrypto.self, forPrimaryKey: symbol) {
            try? realm.write {
                realm.delete(item)
            }
            loadWatchlist()
        }
    }


    func isInWatchlist(symbol: String) -> Bool {
        return realm.object(ofType: WatchlistCrypto.self, forPrimaryKey: symbol) != nil
    }
}
