//
//  HilSportsApp.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 27.08.21.
//

import SwiftUI
import Firebase

@main
struct HilSportsApp: App {
    let persistenceController = PersistenceController.shared

    init(){
        setupAuthentication()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

extension HilSportsApp {
    private func setupAuthentication(){
        FirebaseApp.configure()
    }
}
