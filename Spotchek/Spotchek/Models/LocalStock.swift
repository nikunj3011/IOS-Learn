//
//  LocalStock.swift
//  testSwiftUI
//
//  Created by Nikunj Rathod on 2025-08-21.
//


import Foundation

struct Stock: Identifiable, Decodable {
    var id: String { Symbol }

    let Symbol: String
    let Security: String
    let GICSSector: String
    let GICSSubIndustry: String
    let HeadquartersLocation: String
    let DateAdded: String

    enum CodingKeys: String, CodingKey {
        case Symbol
        case Security
        case GICSSector = "GICS Sector"
        case GICSSubIndustry = "GICS Sub-Industry"
        case HeadquartersLocation = "Headquarters Location"
        case DateAdded = "Date added"
    }
}
