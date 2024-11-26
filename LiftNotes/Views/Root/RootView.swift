//
//  RootView.swift
//  LiftNotes
//
//  Created by Demessie Amede on 2024-10-15.
//

import SwiftUI

struct RootView: View {
    enum Tabs {
        case exercises, workouts, profile
    }
    
    @State var selectedView: Tabs = .workouts
    @State var showingCreateWorkout: Bool = false
    @State var showingCreateExercise: Bool = false
    
    var body: some View {
        TabView (selection: $selectedView) {
            ExercisesTabView(showingCreateExercise: $showingCreateExercise)
                .tabItem {
                    Label("Exercises", systemImage: "tray.and.arrow.down.fill")
                }
                .tag(Tabs.exercises)
            
            WorkoutsTabView(showingCreateWorkout: $showingCreateWorkout)
                .tabItem {
                    Label("Workout", systemImage: "book.pages")
                }
                .tag(Tabs.workouts)
            
            Text("Profile")
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
                .tag(Tabs.profile)
        }
        .fullScreenCover(isPresented: $showingCreateWorkout) {
            CreateWorkoutView()
        }
        .fullScreenCover(isPresented: $showingCreateExercise) {
            CreateExerciseView()
        }
    }
}

#Preview {
    RootView()
}
