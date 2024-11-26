//
//  CreateWorkoutView.swift
//  LiftNotes
//
//  Created by Demessie Amede on 2024-10-18.
//

import SwiftData
import SwiftUI

struct CreateWorkoutView: View {
    @Query<Workout> private var workouts: [Workout]
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var showingExercisePicker = false
    @State private var selectedExercises: [Exercise] = []
    @State private var name: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Workout name", text: $name)
                    .padding()
                    .background(Color(.systemGray6))
                    .foregroundStyle(.black)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding()
                
                // Display selected exercises
                if selectedExercises.isEmpty {
                    Text("No exercises selected.")
                        .foregroundColor(.gray)
                } else {
                    ForEach(selectedExercises) { exercise in
                        Text(exercise.name)
                    }
                }
                
                Spacer()
                
                Button("Add Exercises") {
                    showingExercisePicker = true
                }
                .padding()
                .sheet(isPresented: $showingExercisePicker) {
                    ExercisePickerView(selectedExercises: selectedExercises) { updatedExercises in
                        selectedExercises = updatedExercises
                    }
                }
                
                Button("Create Workout") {
                    createWorkout()
                    dismiss()
                }
            }
            .navigationTitle(name.isEmpty ? "Create Workout" : name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back", systemImage: "xmark") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func createWorkout() {
        let workout = Workout(name: name)
        modelContext.insert(workout)
    }
}

#Preview {
    NavigationStack {
        CreateWorkoutView()
    }
}
