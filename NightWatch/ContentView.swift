//
//  ContentView.swift
//  NightWatch
//
//  Created by Tom Stahl on 12/24/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var nightWatchTasks: NightWatchTasks
    @State private var focusModeOn = false
    @State private var resetAlertShowing = false
    
    var body: some View {
        
        NavigationView {
            List {
                Section(header: TaskSectionHeader(symbolSystemName: "moon.stars", headerText: "Nightly Tasks")) {
                    
                    let taskIndecies = nightWatchTasks.nightlyTasks.indices
                    let tasks = nightWatchTasks.nightlyTasks
                    let taskIndexPairs = Array(zip(tasks, taskIndecies))
                    
                    ForEach(taskIndexPairs, id:\.0.id, content: {
                        task, taskIndex in
                        
                        let nightWatchTasksWrapper = $nightWatchTasks
                        let tasksBinding = nightWatchTasksWrapper.nightlyTasks
                        let taskBinding = tasksBinding[taskIndex]
                        
                        if focusModeOn == false || (focusModeOn && task.isComplete == false){
                            NavigationLink(
                                destination: DetailsView(task: taskBinding),
                                label: {
                                    TaskRow(task: task)
                                })
                        }
                    }).onDelete(perform: { indexSet in
                        nightWatchTasks.nightlyTasks.remove(atOffsets: indexSet)
                    })
                    .onMove(perform: { indices, newOffset in
                        nightWatchTasks.nightlyTasks
                            .move(fromOffsets: indices, toOffset: newOffset)
                    })
                }

                Section(header: TaskSectionHeader(symbolSystemName: "sunset", headerText: "Weekly Tasks")) {
                    
                    let taskIndecies = nightWatchTasks.weeklyTasks.indices
                    let tasks = nightWatchTasks.weeklyTasks
                    let taskIndexPairs = Array(zip(tasks, taskIndecies))
                    
                    ForEach(taskIndexPairs, id:\.0.id, content: {
                        task, taskIndex in
                        
                        let nightWatchTasksWrapper = $nightWatchTasks
                        let tasksBinding = nightWatchTasksWrapper.weeklyTasks
                        let taskBinding = tasksBinding[taskIndex]

                        if focusModeOn == false || (focusModeOn && task.isComplete == false){
                            NavigationLink(
                                destination: DetailsView(task: taskBinding),
                                label: {
                                    TaskRow(task: task)
                                })
                        }
                    }).onDelete(perform: { indexSet in
                        nightWatchTasks.weeklyTasks.remove(atOffsets: indexSet)
                    })
                    .onMove(perform: { indices, newOffset in
                        nightWatchTasks.weeklyTasks
                            .move(fromOffsets: indices, toOffset: newOffset)
                    })
                }
                Section(header: TaskSectionHeader(symbolSystemName: "calendar", headerText: "Monthly Tasks")) {
                    
                    let taskIndecies = nightWatchTasks.monthlyTasks.indices
                    let tasks = nightWatchTasks.monthlyTasks
                    let taskIndexPairs = Array(zip(tasks, taskIndecies))
                    
                    ForEach(taskIndexPairs, id:\.0.id, content: {
                        task, taskIndex in
                        
                        let nightWatchTasksWrapper = $nightWatchTasks
                        let tasksBinding = nightWatchTasksWrapper.monthlyTasks
                        let taskBinding = tasksBinding[taskIndex]

                        if focusModeOn == false || (focusModeOn && task.isComplete == false){
                            NavigationLink(
                                destination: DetailsView(task: taskBinding),
                                label: {
                                    TaskRow(task: task)
                                })
                        }
                    }).onDelete(perform: { indexSet in
                        nightWatchTasks.monthlyTasks.remove(atOffsets: indexSet)
                    })
                    .onMove(perform: { indices, newOffset in
                        nightWatchTasks.monthlyTasks
                            .move(fromOffsets: indices, toOffset: newOffset)
                    })
                }
            }.listStyle(GroupedListStyle())
            .navigationTitle("Home")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Reset"){
                        resetAlertShowing = true
                    }
                }
                ToolbarItem(placement: .bottomBar){
                    Toggle(isOn:
                            $focusModeOn,
                            label: {
                            Text("Focus Mode")
                    })
                }
                
            })
        }.alert(isPresented: $resetAlertShowing, content: {
            Alert(title: Text("Reset List"),
                  message: Text("Are you sure?"),
                  primaryButton: .cancel(),
                  secondaryButton: .destructive(Text("Yes, reset it"),
                                                action: {
                                                    let refreshedNightWatchTasks = NightWatchTasks()
                                                    self.nightWatchTasks.nightlyTasks = refreshedNightWatchTasks.nightlyTasks
                                                    self.nightWatchTasks.weeklyTasks = refreshedNightWatchTasks.weeklyTasks
                                                    self.nightWatchTasks.monthlyTasks = refreshedNightWatchTasks.monthlyTasks
                                                        }))
        })
    }
}



struct TaskSectionHeader: View {
    let symbolSystemName: String
    let headerText: String
    
    var body: some View {
        HStack {
            Image(systemName: symbolSystemName)
            Text(headerText)
        }
        .font(.title3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let nightWatchTasks = NightWatchTasks()
        Group{
            ContentView(nightWatchTasks: nightWatchTasks)
            TaskRow(task: Task(name: "Test task", isComplete: false, lastCompleted: nil))
                .previewLayout(.fixed(width:300, height:70))
        }
        
    }
}

struct TaskRow: View {
    let task: Task
    var body: some View {
        VStack {
            if task.isComplete {
                HStack {
                    Image(systemName: "checkmark.square")
                    Text(task.name)
                        .foregroundColor(.gray)
                        .strikethrough()
                }
            } else {
                HStack {
                    Image(systemName: "square")
                    Text(task.name)
                }
            }
        }
    }
}
