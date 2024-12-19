//
//  FetchTakeHomeApp.swift
//  FetchTakeHome
//
//  Created by Christopher Head on 12/18/24.
//

import SwiftUI
import SwiftData

@main
struct FetchTakeHomeApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            RecipeImage.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(RecipeImageCache(modelContext: sharedModelContainer.mainContext))
    }
}
