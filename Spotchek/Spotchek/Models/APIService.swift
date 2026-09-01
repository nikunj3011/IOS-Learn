//
//  APIService.swift
//  can9
//
//  Created by Nikunj Rathod on 2025-06-24.
//

import Foundation

protocol APIService {
    func fetchListItems() async throws -> [ListItem]
}

class RemoteAPIService: APIService {
    func fetchListItems() async throws -> [ListItem] {
        let url = URL(string: "https://gist.githubusercontent.com/nikunj3011/fd1d0d900448d20419f2c3114e177931/raw/9258b7b2f68a35b5719f239501133f00e5fc553e/gistfile1.json")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([ListItem].self, from: data)
    }
}
