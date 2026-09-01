import SwiftUI
import RealmSwift

class StockViewModel: ObservableObject {
    @Published var stocks: [Stock] = []
    @Published var watchlist: [WatchlistStock] = []

    private var realm = try! Realm()

    // 📥 Load local JSON data
    func loadLocalStocks() {
        guard let url = Bundle.main.url(forResource: "Stocks", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Stock].self, from: data)
            self.stocks = decoded
        } catch {
            print("Error decoding stock JSON: \(error)")
        }
    }

    // ➕ Add to Realm watchlist
    func addToWatchlist(stock: Stock) {
        let item = WatchlistStock()
        item.name = stock.Symbol
        item.symbol = stock.Symbol
        item.name = stock.Security
//        item.category = stock.Category
//        item.price = stock

        try? realm.write {
            realm.add(item, update: .modified)
        }
        loadWatchlist()
    }

    // 🔄 Load Realm watchlist
    func loadWatchlist() {
        let results = realm.objects(WatchlistStock.self)
        self.watchlist = Array(results)
    }

    // 🗑️ Remove from Realm watchlist
    func removeFromWatchlist(symbol: String) {
        let realm = try! Realm()

        if let item = realm.object(ofType: WatchlistStock.self, forPrimaryKey: symbol) {
            try? realm.write {
                realm.delete(item)
            }
            loadWatchlist()
        }
    }

    // 🔍 Check if stock is in watchlist
    func isInWatchlist(symbol: String) -> Bool {
        return realm.object(ofType: WatchlistStock.self, forPrimaryKey: symbol) != nil
    }
}
