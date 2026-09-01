import SwiftUI


// Root View with TabView
struct ContentView5: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "house.fill")
                }
            
            StocksView()
                .tabItem {
                    Label("Stocks", systemImage: "chart.bar.fill")
                }
            
            CryptoView() 
                .tabItem {
                    Label("Crypto", systemImage: "bitcoinsign.circle.fill")
                }
            
            PortfolioView()
                .tabItem {
                    Label("Portfolio", systemImage: "briefcase.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .accentColor(.blue) // Customize theme
    }
}

// Tab 1: Dashboard View
struct DashboardView: View {
    @State private var searchText = ""
    @State private var watchlist: [String] = ["AAPL", "BTC"]
//    @StateObject private var viewModel = StockListViewModel()
//    @StateObject private var viewModel2 = LocalStockViewModel()


//        var filteredTickers: [Ticker] {
//            if searchText.isEmpty {
//                return viewModel.tickers.prefix(10).map { $0 } // Show top 10 as watchlist
//            } else {
//                return viewModel.tickers.filter {
//                    $0.ticker.lowercased().contains(searchText.lowercased()) ||
//                    ($0.name?.lowercased().contains(searchText.lowercased()) ?? false)
//                }
//            }
//        }

        var body: some View {
            NavigationStack {
                VStack {
                    // 🔍 Search Bar
                    TextField("Search stocks...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    // 🖼️ Carousel for Highlights (Static for now)
                    TabView {
                        ForEach(0..<3) { index in
                            VStack {
                                        Text("HTML Content Below")
                                            .font(.headline)
                                            .padding()

                                        HTMLStringView(htmlContent: """
                                            <h2 style='color:blue;'>Welcome to SwiftUI</h2>
                                            <p>This is <strong>HTML-rendered</strong> content inside a SwiftUI view.</p>
                                        """)
                                        .frame(height: 200)
                                        .cornerRadius(10)
                                        .padding()
                                    }
                            .padding()
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(height: 200)

                    // 📈 Watchlist & Highlights
                    List {
//                        Section(header: Text("Watchlist")) {
//                            ForEach(filteredTickers) { ticker in
//                                VStack(alignment: .leading) {
//                                    Text(ticker.ticker)
//                                        .font(.headline)
//                                    Text(ticker.name ?? "Unknown")
//                                        .font(.subheadline)
//                                        .foregroundColor(.gray)
//                                }
//                            }
//                        }

                        Section(header: Text("Market Highlights")) {
                            Grid {
                                GridRow {
                                    HighlightTile(title: "Top Gainer", value: "+5%")
                                    HighlightTile(title: "Top Loser", value: "-3%")
                                }
                            }
                        }
                        
//                        Section(header: Text("Watchlist")) {
//                            ForEach(viewModel2.stocks) { stock in
//                                VStack(alignment: .leading) {
//                                    Text(stock.Symbol)
//                                        .font(.headline)
//                                    Text(stock.Security)
//                                        .font(.subheadline)
//                                        .foregroundColor(.gray)
//                                }
//                            }
//                        }

                    }
                    .listStyle(InsetGroupedListStyle())
                }
                .navigationTitle("Dashboard")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Refresh") {
//                            viewModel2.loadLocalStocks()
                        }
                    }
                }
            }
            .onAppear {
//                viewModel2.loadLocalStocks()
            }
        }
    }
// Placeholder for SearchBar (Custom View)
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search symbols...", text: $text)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

// Placeholder for HighlightCard
struct HighlightCard: View {
    let index: Int
    
    var body: some View {
        VStack {
            Text("Highlight \(index + 1)")
                .font(.headline)
            Text("AI Insight: Bullish trends ahead.")
        }
        .frame(maxWidth: .infinity)
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
    }
}

// Placeholder for InsightCard
struct InsightCard: View {
    let symbol: String
    
    var body: some View {
        HStack {
            Text(symbol)
            Spacer()
            Text("+2.5%")
                .foregroundColor(.green)
        }
    }
}

// Placeholder for HighlightTile
struct HighlightTile: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
            Text(value)
                .font(.title)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}

// Tab 2: Stocks View
struct StocksView: View {
    @StateObject private var viewModel = StockViewModel()

    // UI State
    @State private var searchText = ""
    @State private var sortOption: StockSortOption = .symbol
    @State private var currentPage = 1
    private let itemsPerPage = 1000

    var body: some View {
        VStack {
            // 🔍 Search + Sort Controls
            HStack {
                TextField("Search by name or symbol", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Menu {
                    Picker("Sort by", selection: $sortOption) {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Text(option.rawValue)
                        }
                    }
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                        .padding(.trailing)
                }
            }

            // 📄 Paginated List
            List(paginatedStocks) { stock in
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("\(stock.Symbol). \(stock.Symbol)")
                            .font(.headline)
                        Spacer()
//                        Text(crypto.price)
//                            .font(.subheadline)
                    }

                    Button(action: {
                        viewModel.addToWatchlist(stock: stock)
                    }) {
                        Text(viewModel.isInWatchlist(symbol: stock.Symbol) ? "✓ In Watchlist" : "Add to Watchlist")
                            .font(.caption)
                            .foregroundColor(viewModel.isInWatchlist(symbol: stock.Symbol) ? .green : .blue)
                    }
                }
                .padding(.vertical, 4)
            }

            // ⏩ Pagination Controls
            HStack {
                Button("Previous") {
                    if currentPage > 1 { currentPage -= 1 }
                }
                .disabled(currentPage == 1)

                Spacer()

                Text("Page \(currentPage)")
                    .font(.caption)

                Spacer()

                Button("Next") {
                    if currentPage < totalPages { currentPage += 1 }
                }
                .disabled(currentPage >= totalPages)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .navigationTitle("Cryptocurrencies")
        .onAppear {
            viewModel.loadLocalStocks()
            viewModel.loadWatchlist()
        }
    }

    // 🔍 Filter + Sort + Paginate
    var filteredStocks: [Stock] {
        viewModel.stocks.filter {
            searchText.isEmpty ||
            $0.Symbol.localizedCaseInsensitiveContains(searchText)
        }
        .sorted(by: sortOption.sortFunction)
    }

    var paginatedStocks: [Stock] {
        let start = (currentPage - 1) * itemsPerPage
        let end = min(start + itemsPerPage, filteredStocks.count)
        return Array(filteredStocks[start..<end])
    }

    var totalPages: Int {
        max(1, (filteredStocks.count + itemsPerPage - 1) / itemsPerPage)
    }
}


enum StockSortOption: String, CaseIterable {
    case symbol = "Symbol"
    case name = "Name"
    case price = "Price"

    var sortFunction: (Stock, Stock) -> Bool {
        return { $0.Symbol < $1.Symbol }
//        switch self {
////        case .symbol: return { $0.name < $1.name }
//        case .name: return { $0.name < $1.name }
////        case .price: return { $0.price > $1.price }
//        }
    }
}



// Placeholder for StockCard
struct StockCard: View {
    let index: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Stock \(index + 1)")
                    .font(.headline)
                Text("Price: $150 | +1.2%")
                    .font(.subheadline)
            }
            Spacer()
            // Sparkline Chart (placeholder)
            Rectangle()
                .fill(Color.green)
                .frame(width: 50, height: 30)
        }
    }
}

// Tab 3: Crypto View

struct CryptoView: View {
    @StateObject private var viewModel = CryptoViewModel()

    // UI State
    @State private var searchText = ""
    @State private var sortOption: SortOption = .rank
    @State private var currentPage = 1
    private let itemsPerPage = 1000

    var body: some View {
        VStack {
            // 🔍 Search + Sort Controls
            HStack {
                TextField("Search by name or symbol", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Menu {
                    Picker("Sort by", selection: $sortOption) {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Text(option.rawValue)
                        }
                    }
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                        .padding(.trailing)
                }
            }

            // 📄 Paginated List
            List(paginatedCryptos) { crypto in
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("\(crypto.rank). \(crypto.name)")
                            .font(.headline)
                        Spacer()
                        Text(crypto.price)
                            .font(.subheadline)
                    }

                    Button(action: {
                        viewModel.addToWatchlist(crypto: crypto)
                    }) {
                        Text(viewModel.isInWatchlist(symbol: crypto.symbol) ? "✓ In Watchlist" : "Add to Watchlist")
                            .font(.caption)
                            .foregroundColor(viewModel.isInWatchlist(symbol: crypto.symbol) ? .green : .blue)
                    }
                }
                .padding(.vertical, 4)
            }

            // ⏩ Pagination Controls
            HStack {
                Button("Previous") {
                    if currentPage > 1 { currentPage -= 1 }
                }
                .disabled(currentPage == 1)

                Spacer()

                Text("Page \(currentPage)")
                    .font(.caption)

                Spacer()

                Button("Next") {
                    if currentPage < totalPages { currentPage += 1 }
                }
                .disabled(currentPage >= totalPages)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .navigationTitle("Cryptocurrencies")
        .onAppear {
            viewModel.loadLocalCrypto()
            viewModel.loadWatchlist()
        }
    }

    // 🔍 Filter + Sort + Paginate
    var filteredCryptos: [Crypto] {
        viewModel.cryptos.filter {
            searchText.isEmpty ||
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.symbol.localizedCaseInsensitiveContains(searchText)
        }
        .sorted(by: sortOption.sortFunction)
    }

    var paginatedCryptos: [Crypto] {
        let start = (currentPage - 1) * itemsPerPage
        let end = min(start + itemsPerPage, filteredCryptos.count)
        return Array(filteredCryptos[start..<end])
    }

    var totalPages: Int {
        max(1, (filteredCryptos.count + itemsPerPage - 1) / itemsPerPage)
    }
}


enum SortOption: String, CaseIterable {
    case rank = "Rank"
    case name = "Name"
    case price = "Price"

    var sortFunction: (Crypto, Crypto) -> Bool {
        switch self {
        case .rank: return { $0.rank < $1.rank }
        case .name: return { $0.name < $1.name }
        case .price: return { Double($0.price) ?? 0 > Double($1.price) ?? 0 }
        }
    }
}

// Placeholder for CryptoTile
struct CryptoTile: View {
    let index: Int
    
    var body: some View {
        VStack {
            Image(systemName: "bitcoinsign.circle")
            Text("Crypto \(index + 1)")
            Text("$45,000 | +3%")
                .foregroundColor(.green)
            ProgressView(value: 0.7) // Volatility meter
                .progressViewStyle(LinearProgressViewStyle(tint: .orange))
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

// Tab 4: Portfolio View
struct PortfolioView: View {
    var body: some View {
        TabView {
            CryptoPortfolioTab()
                .tabItem { Label("Crypto", systemImage: "bitcoinsign.circle") }

            StockPortfolioTab()
                .tabItem { Label("Stocks", systemImage: "chart.line.uptrend.xyaxis") }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .navigationTitle("Your Portfolio")
    }
}
import RealmSwift
struct CryptoPortfolioTab: View {
    @ObservedResults(WatchlistCrypto.self) var watchlist

        var body: some View {
            List {
                ForEach(watchlist) { crypto in
                    VStack(alignment: .leading) {
                        Text(crypto.name)
                            .font(.headline)
                        Text("Price: \(crypto.price)")
                        Button("Remove") {
                            $watchlist.remove(crypto)
                        }
                        .foregroundColor(.red)
                        .font(.caption)
                    }
                }
            }
            .navigationTitle("Your Portfolio")
        }
    }
//
struct StockPortfolioTab: View {
    @ObservedResults(WatchlistStock.self) var watchlist

    var body: some View {
        List {
            ForEach(watchlist) { stock in
                VStack(alignment: .leading) {
                    Text(stock.name)
                        .font(.headline)
//                    Text("Price: $\(stock.price, specifier: "%.2f")")
//                    Text("Category: \(stock.category)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Button("Remove") {
                        $watchlist.remove(stock)
                    }
                    .foregroundColor(.red)
                    .font(.caption)
                }
            }
        }
    }
}




// Tab 5: Settings View
struct SettingsView: View {
    @State private var enableVoice = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Preferences")) {
                    Toggle("Enable Voice Mode", isOn: $enableVoice)
                    Picker("Theme", selection: .constant("Light")) {
                        Text("Light")
                        Text("Dark")
                    }
                }
                
                Section(header: Text("API Settings")) {
                    TextField("Stock API Key", text: .constant(""))
                }
                
                Section {
                    Link("About SuperGrok", destination: URL(string: "https://x.ai/grok")!)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

// Preview Provider
#Preview {
    ContentView5()
}
