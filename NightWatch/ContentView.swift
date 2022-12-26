//
//  ContentView.swift
//  NightWatch
//
//  Created by Tom Stahl on 12/24/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var nightWatchTasks: NightWatchTasks
    
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
                        
                        NavigationLink(
                            destination: DetailsView(task: taskBinding),
                            label: {
                                TaskRow(task: task)
                            })
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

                        NavigationLink(
                            destination: DetailsView(task: taskBinding),
                            label: {
                                TaskRow(task: task)
                            })
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

                        NavigationLink(
                            destination: DetailsView(task: taskBinding),
                            label: {
                                TaskRow(task: task)
                            })
                    })
                }
            }.listStyle(GroupedListStyle())
            .navigationTitle("Home")
        }
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

//struct ControlPanel: View {
//
//    var body: some View {
//        HStack{
//            if theTask.isComplete == false{
//                Button(action: {
//                    theTask.isComplete = true
//                }) {
//                    Text("Mark Complete")
//                }.padding(.top)
//            } else {
//                Button(action: {
//                    theTask.isComplete = false
//                }) {
//                    Text("Reset")
//                }.padding(.top)
//            }
//        }
//    }
//}

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
