//
//  WorkoutsTabView.swift
//  LiftNotes
//
//  Created by Demessie Amede on 2024-10-16.
//

import SwiftData
import SwiftUI

struct WorkoutsTabView: View {
    @Environment(\.modelContext) var modelContext
    @Query<Workout> var allWorkouts: [Workout]
    @Query(sort: \Workout.lastCompletedAt, order: .reverse) var recentWorkouts: [Workout]
    @Binding var showingCreateWorkout: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.opacity(0.03)
                    .ignoresSafeArea()
                content
            }
        }
    }
    
    var content: some View {
        VStack {
            Text("Recently done \(recentWorkouts.count == 0 ? "" : "(\(recentWorkouts.count))")")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal) {
                LazyHStack {
                    if recentWorkouts.isEmpty {
                        VStack(alignment: .center) {
                            Text("No workouts yet")
                        }
                    }
                    
                    ForEach(recentWorkouts) { recentWorkout in
                        
                        NavigationLink {
                           
                        } label: {
                            NavigationLink {
                                
                            } label: {
                                VStack {
                                    Text(recentWorkout.name)
                                    Text((recentWorkout.lastCompletedAt?.formatted(date: .abbreviated, time: .complete))!)
                                }
                                .foregroundStyle(.black)
                                .frame(width: 150, height: 125)
                                .background(.white)
                                .clipShape(.rect(cornerRadius: 20))
                                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 4)
                            }
                        }
                        .simultaneousGesture(
                            TapGesture().onEnded {
                                recentWorkout.lastCompletedAt = .now
                            }
                        )
                    }
                }
                .padding(.horizontal)
                .frame(minWidth: UIScreen.main.bounds.width)
            }
            .scrollIndicators(.hidden)
            .frame(height: 150)
            
            
            Button("Create Workout") {
                showingCreateWorkout = true
            }
            .padding()
            .buttonStyle(.borderedProminent)
            
            Button ("Remove All Workouts") {
                removeAllWorkouts()
            }
            .foregroundStyle(.red)
            .padding()
            
        }
        .navigationTitle("Workouts")
    }
    
    func addWorkout(_ workout: Workout) {
        modelContext.insert(workout)
    }
    
    func removeAllWorkouts() {
        for workout in allWorkouts {
            modelContext.delete(workout)
        }
    }
}

#Preview {
    WorkoutsTabView(showingCreateWorkout: .constant(false))
}
