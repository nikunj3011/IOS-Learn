//
//  WatchlistCrypto.swift
//  testSwiftUI
//
//  Created by Nikunj Rathod on 2025-08-24.
//


import Foundation
import RealmSwift

class WatchlistCrypto: Object, Identifiable {
    @Persisted(primaryKey: true) var symbol: String
    @Persisted var name: String
    @Persisted var price: String

    var id: String { symbol }
}

