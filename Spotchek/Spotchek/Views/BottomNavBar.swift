//
//  BottomNavBar.swift
//  testSwiftUI
//
//  Created by Nikunj Rathod on 2025-07-15.
//
import SwiftUI

struct BottomNavBar: View {
    @Binding var activePage: Int

    var body: some View {
        HStack {
            Button("Home") {
                withAnimation {
                    activePage = 0
                }
            }
            .frame(maxWidth: .infinity)

            Button("Market") {
                withAnimation {
                    activePage = 1
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 4)
        .padding(.horizontal)
    }
}

