//
//  VehicleMarketView.swift
//  can9
//
//  Created by Nikunj Rathod on 2025-06-24.
//


import SwiftUI

struct VehicleMarketView: View {
    @State private var selectedMarket: Market = .canadian
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // Header
                HStack {
                    Text("Vehicle Market")
                        .font(.headline)
                        .foregroundColor(.blue)
                    Spacer()
                    Image(systemName: "gear")
                        .foregroundColor(.gray)
                }
                .padding()
                
                // Form Container
                VStack(alignment: .leading, spacing: 8) {
                    Text("Destination Market")
                        .font(.title2)
                        .bold()
                    
                    Text("Choose the vehicle location to ensure the correct unit of measurement for vehicle data.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    // Radio Button Group
                    VStack(alignment: .leading, spacing: 12) {
                        RadioButton(
                            title: "United States Market (Imperial Measurement - Miles)",
                            isSelected: selectedMarket == .us
                        ) {
                            selectedMarket = .us
                        }
                        
                        RadioButton(
                            title: "Canadian Market (Metric Measurement - Kilometers)",
                            isSelected: selectedMarket == .canadian
                        ) {
                            selectedMarket = .canadian
                        }
                    }
                    .padding(.top, 8)
                    
                    Spacer()
                    
                    // Next Button
                    Button(action: {
                        // Handle next action
                    }) {
                        Text(">")
                            .font(.title)
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 16)
                }
                .padding()
                
                // Background lines (decorative)
                ZStack {
                    Path { path in
                        let center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
                        for i in 0...5 {
                            path.move(to: CGPoint(x: center.x - 100, y: center.y + CGFloat(i) * 20))
                            path.addLine(to: CGPoint(x: center.x + 100, y: center.y + CGFloat(i) * 20))
                        }
                    }
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("")
            .background(Color(UIColor.systemBackground))
        }
    }
}

// Radio Button Component
struct RadioButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(isSelected ? .blue : .gray)
                Text(title)
                    .foregroundColor(.primary)
            }
        }
    }
}

// Enum for Market Selection
enum Market {
    case us
    case canadian
}

#Preview {
    VehicleMarketView()
}