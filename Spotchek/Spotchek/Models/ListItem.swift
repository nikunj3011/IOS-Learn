//
//  ListItem.swift
//  can9
//
//  Created by Nikunj Rathod on 2025-06-24.
//

import Foundation

struct ListItem: Identifiable, Decodable {
    let id: UUID
    let title: String
    let subtitle: String
    let shareURL: URL?

    // Optional: Custom init with default
    init(id: UUID = UUID(), title: String, subtitle: String, shareURL: URL = URL(string: "https://example.com/share")!) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.shareURL = shareURL
    }
}

