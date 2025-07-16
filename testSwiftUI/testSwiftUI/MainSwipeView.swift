import SwiftUI

struct SlideDrawerView: View {
    @State private var offset: CGFloat = 0
    @State private var isChatActive: Bool = false
    @State private var chatInput: String = ""
    @State private var activePage: Int = 0 // 0 = Home, 1 = Market

    let screenWidth = UIScreen.main.bounds.width

    var body: some View {
        ZStack {
            // Main + Market Views
            ZStack(alignment: .bottom) {
                Group {
                    if activePage == 0 {
                        MainPageView(isChatActive: $isChatActive, chatInput: $chatInput)
                    } else {
                        MarketPageView()
                    }
                }
                .blur(radius: blurAmount(for: offset))
                .frame(width: screenWidth)
                .offset(x: offset)

                // Bottom Nav only when companion panel is not active
                if offset == 0 {
                    BottomNavBar(activePage: $activePage)
                }
            }

            // Companion Panel
            CompanionPanelView(isChatActive: $isChatActive, chatInput: $chatInput)
                .frame(width: screenWidth)
                .offset(x: -screenWidth + offset)
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    let newOffset = offset + value.translation.width
                    offset = min(max(newOffset, 0), screenWidth)
                }
                .onEnded { value in
                    let predictedOffset = offset + value.translation.width
                    let threshold = screenWidth / 3
                    withAnimation(.easeInOut(duration: 0.6)) {
                        offset = predictedOffset > threshold ? screenWidth : 0
                    }
                }
        )
        .edgesIgnoringSafeArea(.all)
    }

    private func blurAmount(for offset: CGFloat) -> CGFloat {
        let progress = min(max(offset / screenWidth, 0), 1)
        return progress * 8
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
            
            // Chat Response Placeholder
            if isChatActive {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Grok's Response")
                        .font(.headline)
                    Text("This is a placeholder for Grok's response to: '\(chatInput)'")
                        .foregroundColor(.secondary)
                    // Placeholder for DeepSearch or Image Generation
                    Text("DeepSearch: Analyzing web and X data...")
                        .foregroundColor(.blue)
                    Button("Generate Image") {
                        // Placeholder for image generation
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

struct MainPageView: View {
    @Binding var isChatActive: Bool
    @Binding var chatInput: String

    var body: some View {
        VStack {
            Spacer().frame(height: 60)
            Text("🧠 Grok-Style Dashboard")
                .font(.largeTitle)
                .bold()
                .padding()

            Spacer()

            Text("Swipe left to summon your AI companion")
                .foregroundColor(.gray)
                .padding(.bottom)
        }
        .frame(maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

struct MarketPageView: View {
    @State private var selectedTab = 0
    @State private var offset: CGFloat = 0
    @GestureState private var dragTranslation: CGFloat = 0
    @State private var isChatActive: Bool = false
    @State private var chatInput: String = ""

    let tabTitles = ["Trending", "Favorites", "Categories"]
    let screenWidth = UIScreen.main.bounds.width

    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 60)

            // Tab Indicator
            HStack {
                ForEach(0..<tabTitles.count, id: \.self) { index in
                    Text(tabTitles[index])
                        .font(.headline)
                        .foregroundColor(index == selectedTab ? .blue : .gray)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            withAnimation {
                                selectedTab = index
                            }
                        }
                }
            }
            .padding(.vertical, 12)
            .background(Color.white)
            .shadow(radius: 2)

            // TabView with drag only on Trending tab
            ZStack {
                TabView(selection: $selectedTab) {
                    // Trending tab with drag
                    ZStack(alignment: .trailing) {
                        MarketTabView(title: "Trending")
                            .frame(width: screenWidth)
                            .blur(radius: blurAmount(for: offset + dragTranslation))

                        CompanionPanelView(isChatActive: $isChatActive, chatInput: $chatInput)
                            .frame(width: screenWidth)
                            .offset(x: -screenWidth + offset + dragTranslation)

                        // Transparent gesture layer
                        Color.clear
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        // Only trigger if dragging left and not too vertical
                                        if value.translation.width < -10 && abs(value.translation.height) < 30 {
                                            let newOffset = offset + value.translation.width
                                            offset = min(max(newOffset, 0), screenWidth)
                                        }
                                    }
                                    .onEnded { value in
                                        let predictedOffset = offset + value.translation.width
                                        let threshold = screenWidth / 3
                                        withAnimation(.easeInOut(duration: 0.6)) {
                                            offset = predictedOffset > threshold ? screenWidth : 0
                                        }
                                    }
                            )
                    }
                    .tag(0)


                    // Other tabs (no drag)
                    MarketTabView(title: "Favorites").tag(1)
                    MarketTabView(title: "Categories").tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }

            // Bottom Nav only when on Trending tab and panel is closed
            if selectedTab == 0 && offset == 0 {
                BottomNavBar(activePage: .constant(1)) // or pass real binding if needed
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }

    private func blurAmount(for offset: CGFloat) -> CGFloat {
        let progress = min(max(offset / screenWidth, 0), 1)
        return progress * 8
    }
}




struct BottomSheetContent: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("🧾 Sheet Content")
                .font(.title2)
                .bold()

            Text("This could be filters, settings, or anything else.")
                .multilineTextAlignment(.center)
                .padding()

            Spacer()
        }
        .padding()
        .presentationDetents([.medium, .large]) // Optional: iOS 16+
    }
}

struct MarketTabView: View {
    let title: String

    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .bold()
                .padding()

            Spacer()

            Text("Swipe left or right to change tab")
                .foregroundColor(.gray)
                .padding(.bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
    }
}


