//
//  ExercisePickerView.swift
//  LiftNotes
//
//  Created by Demessie Amede on 2024-10-19.
//

import SwiftData
import SwiftUI

struct ExercisePickerView: View {
    @Environment(\.dismiss) var dismiss
    @Query<Exercise> var exercises: [Exercise]
    
    @State private var selectedExerciseIDs: Set<Exercise.ID>
    var onSelection: ([Exercise]) -> Void
    
    init(selectedExercises: [Exercise], onSelection: @escaping ([Exercise]) -> Void) {
        _selectedExerciseIDs = State(initialValue: Set(selectedExercises.map { $0.id }))
        self.onSelection = onSelection
    }
    
    var body: some View {
        NavigationStack {
            List(exercises, selection: $selectedExerciseIDs) { exercise in
                Text(exercise.name).tag(exercise.id)
            }
            .environment(\.editMode, .constant(EditMode.active))
            .navigationTitle("Select Exercises")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        let updatedSelection = exercises.filter { selectedExerciseIDs.contains($0.id) }
                        onSelection(updatedSelection)
                        dismiss()
                    }
                }
            }
            
            Text("\(selectedExerciseIDs.count)")
        }
    }
}

#Preview {
    ExercisePickerView(selectedExercises: []) { _ in }
}
