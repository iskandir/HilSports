//
//  HilSportsApp.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 27.08.21.
//

import SwiftUI

@main
struct HilSportsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
