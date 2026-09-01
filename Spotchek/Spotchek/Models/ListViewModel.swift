//
//  ListViewModel.swift
//  can9
//
//  Created by Nikunj Rathod on 2025-06-24.
//
import Foundation

@Observable
class ListViewModel {
    private let service: APIService

    init(service: APIService = RemoteAPIService()) {
        self.service = service
    }

    var items: [ListItem] = []
    var isLoading = false
    var errorMessage: String?

    func loadItems() async {
        isLoading = true
        do {
            items = try await service.fetchListItems()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
