////
////  LocalStockViewModel.swift
////  testSwiftUI
////
////  Created by Nikunj Rathod on 2025-08-21.
////
//
//
//import Foundation
//
//class LocalStockViewModel: ObservableObject {
//    @Published var stocks: [LocalStock] = []
//
//    func loadLocalStocks() {
//        guard let url = Bundle.main.url(forResource: "Stocks", withExtension: "json") else {
//            print("JSON file not found")
//            return
//        }
//
//        do {
//            let data = try Data(contentsOf: url)
//            let decodedStocks = try JSONDecoder().decode([LocalStock].self, from: data)
//            self.stocks = decodedStocks
//        } catch {
//            print("Error decoding local JSON: \(error)")
//        }
//    }
//}
