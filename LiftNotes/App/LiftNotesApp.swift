//
//  LiftNotesApp.swift
//  LiftNotes
//
//  Created by Demessie Amede on 2024-10-15.
//

import SwiftData
import SwiftUI

@main
struct LiftNotesApp: App {
    //var modelContainer = ModelContainer(for: WorkoutTemplate.self, Exercise.self, Note.self)

    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [Workout.self, Exercise.self])
    }
}
