//
//  Workout.swift
//  LiftNotes
//
//  Created by Demessie Amede on 2024-10-15.
//

import Foundation
import SwiftData

@Model
final class Workout: Identifiable {
    var id: UUID
    var name: String
    var exercises: [Exercise]
    var universalRestTime: TimeInterval
    var lastCompletedAt: Date?
    
    init(name: String, exercises: [Exercise] = [], universalRestTime: TimeInterval = .zero) {
        self.id = UUID()
        self.name = name
        self.exercises = exercises
        self.universalRestTime = universalRestTime
        self.lastCompletedAt = DateUtils.farPast
    }
    
    func addExercise(_ exercise: Exercise) {
        exercises.append(exercise)
    }
    
    func removeExercise(_ exercise: Exercise) {
        exercises.removeAll(where: { $0.id == exercise.id })
    }
}

extension Workout {
    static let MOCK_WORKOUT = Workout(name: "Mock Workout")
}

@Model
final class CompletedWorkout {
    var name: String
    var date: Date
    var exercises: [Exercise]
    var duration: TimeInterval
    
    init(name: String, date: Date, exercises: [Exercise], duration: TimeInterval) {
        self.name = name
        self.date = date
        self.exercises = exercises
        self.duration = duration
    }
}

@Model
final class WorkoutHistory {
    var completedWorkouts: [CompletedWorkout]
    
    init() {
        self.completedWorkouts = []
    }
    
    // Method to add a completed workout to history
    func addCompletedWorkout(_ workout: CompletedWorkout) {
        completedWorkouts.append(workout)
    }
    
    // You could also add methods for filtering, sorting, etc.
}
