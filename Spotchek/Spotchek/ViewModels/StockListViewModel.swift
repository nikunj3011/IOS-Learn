

import Foundation
import SwiftUI
import RealmSwift
import Combine

class StockViewModel: ObservableObject {
    @Published var stocks: [Stock] = []
    @Published var watchlist: [WatchlistStock] = []

    private var realm: Realm?

    init() {
        do {
            // Safe initialization to prevent crashes on migration errors
            self.realm = try Realm()
            loadLocalStocks()
            loadWatchlist()
        } catch {
            print("Realm init error: \(error.localizedDescription)")
        }
    }

    // 📥 Load local JSON data (Background Threaded)
    func loadLocalStocks() {
        guard let url = Bundle.main.url(forResource: "Stocks", withExtension: "json") else { return }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                let decoded = try JSONDecoder().decode([Stock].self, from: data)
                
                DispatchQueue.main.async {
                    self?.stocks = decoded
                }
            } catch {
                print("Error decoding stock JSON: \(error)")
            }
        }
    }

    // ➕ Add to Realm watchlist
    func addToWatchlist(stock: Stock) {
        guard let realm = realm else { return }
        
        let item = WatchlistStock()
        item.symbol = stock.Symbol
        item.name = stock.Security
        // item.category = stock.Category // Uncomment if these exist in your model

        try? realm.write {
            // .modified requires a PrimaryKey in your WatchlistStock model
            realm.add(item, update: .modified)
        }
        loadWatchlist()
    }

    // 🔄 Load Realm watchlist
    func loadWatchlist() {
        guard let realm = realm else { return }
        let results = realm.objects(WatchlistStock.self)
        
        // Updating @Published must happen on the main thread
        DispatchQueue.main.async {
            self.watchlist = Array(results)
        }
    }

    // 🗑️ Remove from Realm watchlist
    func removeFromWatchlist(symbol: String) {
        guard let realm = realm else { return }

        if let item = realm.object(ofType: WatchlistStock.self, forPrimaryKey: symbol) {
            try? realm.write {
                realm.delete(item)
            }
            loadWatchlist()
        }
    }

    // 🔍 Check if stock is in watchlist
    func isInWatchlist(symbol: String) -> Bool {
        return realm?.object(ofType: WatchlistStock.self, forPrimaryKey: symbol) != nil
    }
}
