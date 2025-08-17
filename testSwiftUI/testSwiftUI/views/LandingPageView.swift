import SwiftUI



struct LandingPageView: View {
    @State private var showMainApp: Bool = false
    @State private var animateContent: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            if showMainApp {
                MainAppView()
                    .transition(.move(edge: .bottom))
            } else {
                VStack(spacing: 20) {
                    VStack(spacing: 10) {
                        Text("🧠 Welcome to Grok")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.primary)
                            .scaleEffect(animateContent ? 1 : 0.8)
                            .opacity(animateContent ? 1 : 0)
                        
                        Text("Your AI-powered social companion on X")
                            .font(.title3)
                            .foregroundColor(.secondary)
                            .opacity(animateContent ? 1 : 0)
                    }
                    .padding(.top, 50)
                    
                    ScrollView {
                        VStack(spacing: 15) {
                            FeatureCard(
                                icon: "message.fill",
                                title: "AI Chat",
                                description: "Ask Grok anything, from insights to image generation."
                            )
                            .offset(y: animateContent ? 0 : 50)
                            .opacity(animateContent ? 1 : 0)
                            
                            FeatureCard(
                                icon: "flame.fill",
                                title: "Trending Topics",
                                description: "Stay updated with what’s hot on X."
                            )
                            .offset(y: animateContent ? 0 : 50)
                            .opacity(animateContent ? 1 : 0)
                            
                            FeatureCard(
                                icon: "star.fill",
                                title: "For You",
                                description: "Personalized posts tailored to your interests."
                            )
                            .offset(y: animateContent ? 0 : 50)
                            .opacity(animateContent ? 1 : 0)
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showMainApp = true
                        }
                    }) {
                        Text("Get Started")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .offset(y: animateContent ? 0 : 50)
                    .opacity(animateContent ? 1 : 0)
                    .padding(.bottom, 30)
                }
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8).delay(0.2)) {
                animateContent = true
            }
        }
    }
}

struct FeatureCard: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 50)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
    }
}

struct MainAppView: View {
    var body: some View {
        TabView {
            SlideDrawerView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ForYouView()
                .tabItem {
                    Label("For You", systemImage: "star")
                }
            
            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
            
            NotificationsView()
                .tabItem {
                    Label("Notifications", systemImage: "bell")
                }
            
            MessagesView()
                .tabItem {
                    Label("Messages", systemImage: "envelope")
                }
        }
        .accentColor(.blue)
    }
}

struct ForYouView: View {
    var body: some View {
        VStack {
            Text("For You")
                .font(.largeTitle)
                .bold()
            Text("Personalized feed with trending posts")
                .foregroundColor(.gray)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

struct ExploreView: View {
    var body: some View {
        VStack {
            Text("Explore")
                .font(.largeTitle)
                .bold()
            Text("Trending topics and hashtags")
                .foregroundColor(.gray)
            List {
                Text("#SwiftUI")
                Text("#iOSDevelopment")
                Text("#GrokAI")
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

struct NotificationsView: View {
    var body: some View {
        VStack {
            Text("Notifications")
                .font(.largeTitle)
                .bold()
            Text("Mentions, likes, and reposts")
                .foregroundColor(.gray)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

struct MessagesView: View {
    var body: some View {
        VStack {
            Text("Messages")
                .font(.largeTitle)
                .bold()
            Text("Direct messages with users")
                .foregroundColor(.gray)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}
struct SlideDrawerView: View {
    @State private var selectedTab: Int = 0
    @State private var isChatActive: Bool = false
    @State private var chatInput: String = ""
    
    let screenWidth = UIScreen.main.bounds.width
    let tabs = ["All", "Watchlist", "New", "Gainers", "Losers"]
    
    var body: some View {
        VStack(spacing: 15) {
            // Header with Search and Status
            HStack {
//                Text("12:06") // Simulated time
//                    .foregroundColor(.gray)
//                Spacer()
//                Image(systemName: "battery.75")
//                Image(systemName: "wifi")
//                Text("5G")
//                    .foregroundColor(.gray)
            }
            .padding()
            
            // Search Bar
            TextField("Search for a market", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
            
            // Filter Tabs (Visible and Tappable)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(tabs.indices, id: \.self) { index in
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.6)) {
                                selectedTab = index
                            }
                        }) {
                            Text(tabs[index])
                                .padding(.horizontal, 15)
                                .padding(.vertical, 8)
                                .background(selectedTab == index ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            // Crypto List (Content based on selected tab)
            List {
                if tabs[selectedTab] == "All" || tabs[selectedTab] == "Watchlist" {
                    CryptoRow(symbol: "BTC-USDC", price: "$113,493.65", volume: "Vol 553.71M", change: "-0.96%")
                    CryptoRow(symbol: "ETH-USDC", price: "$3,583.14", volume: "Vol 413.81M", change: "-2.42%")
                }
                if tabs[selectedTab] == "New" {
                    CryptoRow(symbol: "SUI-USDC", price: "$3.3660", volume: "Vol 40.7M", change: "-4.99%")
                    CryptoRow(symbol: "BONK-USDC", price: "$0.00002356", volume: "Vol 34.47M", change: "-9.52%")
                }
                if tabs[selectedTab] == "Gainers" {
                    CryptoRow(symbol: "BTC-USDC", price: "$113,493.65", volume: "Vol 553.71M", change: "+1.96%")
                }
                if tabs[selectedTab] == "Losers" {
                    CryptoRow(symbol: "ETH-USDC", price: "$3,583.14", volume: "Vol 413.81M", change: "-2.42%")
                }
            }
            .listStyle(PlainListStyle())
            .background(Color.black)
            
//            // Bottom Navigation
//            HStack(spacing: 30) {
//                Image(systemName: "waveform")
//                    .foregroundColor(.white)
//                Image(systemName: "arrow.up.arrow.down")
//                    .foregroundColor(.white)
//                Image(systemName: "chart.bar")
//                    .foregroundColor(.white)
//                Image(systemName: "briefcase")
//                    .foregroundColor(.white)
//                Image(systemName: "list.dash")
//                    .foregroundColor(.white)
//            }
//            .padding()
//            .background(Color.gray.opacity(0.3))
        }
        .background(Color.black)
        .foregroundColor(.white)
        .gesture(
            DragGesture()
                .onEnded { value in
                    let threshold = screenWidth / 3
                    withAnimation(.easeInOut(duration: 0.6)) {
                        if value.translation.width < -threshold {
                            // Swipe left: move to next tab
                            selectedTab = (selectedTab + 1) % tabs.count
                        } else if value.translation.width > threshold {
                            // Swipe right: move to previous tab
                            selectedTab = (selectedTab - 1 + tabs.count) % tabs.count
                        }
                    }
                }
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct MainPageView: View {
    @Binding var isChatActive: Bool
    @Binding var chatInput: String
    let currentTab: String
    
    var body: some View {
        // This view is now part of the SlideDrawerView's tab logic
        EmptyView() // No longer used independently, handled by SlideDrawerView
    }
}

struct CryptoRow: View {
    let symbol: String
    let price: String
    let volume: String
    let change: String
    
    var body: some View {
        HStack {
            Image(systemName: symbol.contains("BTC") ? "bitcoinsign.circle.fill" :
                  symbol.contains("ETH") ? "circle.fill" :
                  symbol.contains("SUI") ? "suit.heart.fill" :
                  symbol.contains("BONK") ? "pawprint.fill" : "circle.fill")
                .foregroundColor(.blue)
                .frame(width: 30)
            
            VStack(alignment: .leading) {
                Text(symbol)
                    .font(.headline)
                Text(volume)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(price)
                    .font(.headline)
                Text(change)
                    .font(.subheadline)
                    .foregroundColor(change.contains("-") ? .red : .green)
                    .overlay(
                        Image(systemName: change.contains("-") ? "arrow.down" : "arrow.up")
                            .foregroundColor(change.contains("-") ? .red : .green)
                            .offset(x: 5, y: 0)
                    )
            }
        }
        .padding(.vertical, 5)
    }
}

struct FilterTab: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        Text(title)
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
            .foregroundColor(isSelected ? .white : .white)
            .cornerRadius(15)
    }
}

struct CompanionPanelView: View {
    @Binding var isChatActive: Bool
    @Binding var chatInput: String
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 60)
            Text("🤖 Grok AI Companion")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            if isChatActive {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Grok's Response")
                        .font(.headline)
                    Text("This is a placeholder for Grok's response to: '\(chatInput)'")
                        .foregroundColor(.secondary)
                    Text("DeepSearch: Analyzing web and X data...")
                        .foregroundColor(.blue)
                    Button("Generate Image") {
                        // Placeholder
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                }
                .padding(.horizontal)
            } else {
                Text("Enter a query on the main page to interact with Grok")
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            Text("Swipe left to return")
                .foregroundColor(.gray)
                .padding(.bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
