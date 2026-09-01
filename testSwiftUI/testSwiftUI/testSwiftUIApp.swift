//
//  testSwiftUIApp.swift
//  testSwiftUI
//
//  Created by Nikunj Rathod on 2025-07-15.
//

import SwiftUI
import RealmSwift

@main
struct testSwiftUIApp: SwiftUI.App {
    init() {
            let config = Realm.Configuration(
                schemaVersion: 1,
                deleteRealmIfMigrationNeeded: true
            )
            Realm.Configuration.defaultConfiguration = config
        }
    var body: some Scene {
        WindowGroup {
            ContentView5()
        }
    }
}
