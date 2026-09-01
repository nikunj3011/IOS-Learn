//
//  WatchlistStock.swift
//  testSwiftUI
//
//  Created by Nikunj Rathod on 2025-08-24.
//


import Foundation
import RealmSwift

class WatchlistStock: Object, Identifiable {
    @Persisted(primaryKey: true) var symbol: String
    @Persisted var name: String
//    @Persisted var category: String  e.g., "Tech", "Finance"
//    @Persisted var price: Double
    
    var id: String { symbol }
}
