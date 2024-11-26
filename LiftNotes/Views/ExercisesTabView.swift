//
//  ExercisesView.swift
//  LiftNotes
//
//  Created by Demessie Amede on 2024-10-16.
//

import SwiftUI
import SwiftData

struct ExercisesTabView: View {
    @Environment(\.modelContext) var modelContext
    @Query<Exercise> var exercises: [Exercise]
    @State private var searchText: String = ""
    @Binding var showingCreateExercise: Bool
    
    var filteredExercises: [Exercise] {
        exercises.filter { exercise in
            searchText.isEmpty || exercise.name.localizedStandardContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.opacity(0.03)
                    .ignoresSafeArea()
                content
            }
        }
        .searchable(text: $searchText)
    }
    
    var content: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(filteredExercises) { exercise in
                        NavigationLink {
                            
                        } label: {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(exercise.name)
                                    .font(.headline)
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                            )
                        }
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .scrollIndicators(.hidden)
            
            Button("Add Exercise") {
                showingCreateExercise = true
            }
            
            Button("Remove All Exercises") {
                removeAllExercises()
            }
            .foregroundStyle(.red)
            .padding()
        }
        .navigationTitle("Exercises")
        .toolbar {
            Button("Add exercise", systemImage: "plus") {
                showingCreateExercise = true
            }
        }
    }
    
    func removeAllExercises() {
        for exercise in exercises {
            modelContext.delete(exercise)
        }
    }
}

#Preview {
    ExercisesTabView(showingCreateExercise: .constant(false))
}
