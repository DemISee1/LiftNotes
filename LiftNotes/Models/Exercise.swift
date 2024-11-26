//
//  Exercise.swift
//  LiftNotes
//
//  Created by Demessie Amede on 2024-10-16.
//

import Foundation
import SwiftData

enum ExerciseType: String, Codable {
    case weight, duration
}

@Model
final class Exercise: Identifiable {
    var id: UUID
    var name: String
    var history: [ExerciseStats]
    var typeRawValue: String
    
//    var type: ExerciseType {
//        get {
//            ExerciseType(rawValue: typeRawValue) ?? .weight
//        }
//        set {
//            typeRawValue = newValue.rawValue
//        }
//    }
    
    var mostRecentStats: ExerciseStats? { history.last }
    var maxStats: ExerciseStats? { history.max() }
 
    init(name: String, type: ExerciseType) {
        self.id = UUID()
        self.name = name
        self.history = []
        self.typeRawValue = type.rawValue
    }
    
    func perform(with stats: ExerciseStats) {
        history.append(stats)
        
        // Stored property version of maxStats
//        if maxStats == nil || maxStats! < stats { // FLAG: Check if force-unwrapping causes issues later
//            maxStats = stats
//        }
    }
}

extension Exercise {
    static let MOCK_EXERCISE = Exercise(name: "Mock Exercise", type: .weight)
}

@Model
final class ExerciseStats: Comparable {
    var weight: Double?
    var sets: Int?
    var reps: Int?
    var rest: TimeInterval?
    var duration: TimeInterval?
    
    init(weight: Double? = nil, sets: Int? = nil, reps: Int? = nil, rest: TimeInterval? = nil, duration: TimeInterval? = nil) {
        self.weight = weight
        self.sets = sets
        self.reps = reps
        self.rest = rest
        self.duration = duration
    }
    
    static func < (lhs: ExerciseStats, rhs: ExerciseStats) -> Bool {
        let lhsWeight = lhs.weight ?? 0
        let rhsWeight = rhs.weight ?? 0
        let lhsTotalReps = (lhs.reps ?? 0) * (lhs.sets ?? 0)
        let rhsTotalReps = (rhs.reps ?? 0) * (rhs.sets ?? 0)
        
        return lhsWeight < rhsWeight || (lhsWeight == rhsWeight && lhsTotalReps < rhsTotalReps)
    }
    
    static func == (lhs: ExerciseStats, rhs: ExerciseStats) -> Bool {
        return lhs.weight == rhs.weight
                && lhs.reps == rhs.reps
                && lhs.sets == rhs.sets
                && lhs.duration == rhs.duration
    }
}

extension ExerciseStats {
    static let MOCK_STATS = ExerciseStats(weight: 100, sets: 3, reps: 5, rest: 10, duration: 100)
}

//protocol ExerciseStatsz: Comparable {
//    var rest: TimeInterval? { get }
//}

//final class ExerciseSet: ExerciseStatsz {
//    static func < (lhs: ExerciseSet, rhs: ExerciseSet) -> Bool {
//        weight 
//    }
//    
//    static func == (lhs: ExerciseSet, rhs: ExerciseSet) -> Bool {
//        <#code#>
//    }
//    
//    var weight: Double?
//    var reps: Int?
//    var rest: TimeInterval?
//    
//    
//}
//
//final class ExerciseInterval: ExerciseStatsz {
//    var duration: TimeInterval?
//    var rest: TimeInterval?
//}
