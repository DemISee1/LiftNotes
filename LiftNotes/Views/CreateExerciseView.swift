//
//  CreateExerciseView.swift
//  LiftNotes
//
//  Created by Demessie Amede on 2024-10-17.
//

import SwiftData
import SwiftUI

struct CreateExerciseView: View {
    @Query<Exercise> var exercises: [Exercise]
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State var name: String = ""
    @State var sets: String = ""
    @State var reps: String = ""
    @State var weight: String = ""
    @State var duration: String = ""
    @State var rest: String = ""
    @State var type: ExerciseType = .weight
    

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Name", text: $name)
                        .keyboardType(.alphabet)
                    
                    Picker("Exercise Type", selection: $type) {
                        Text("Weight").tag( ExerciseType.weight)
                        Text("Duration").tag(ExerciseType.duration)
                    }
                    .pickerStyle(.inline)
            
                    Button("Create exercise") {
                        createExercise()
                        dismiss()
                    }
                    
                }
            }
            .navigationTitle(name.isEmpty ? "New Exercise" : name)
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
    
    func createExercise() {
        let exercise: Exercise = Exercise(name: name, type: type)
        print("--- Creating Exercise")
        modelContext.insert(exercise)
    }
}

#Preview {
    CreateExerciseView()
}
