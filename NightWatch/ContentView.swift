//
//  ContentView.swift
//  NightWatch
//
//  Created by Tom Stahl on 12/24/22.
//

import SwiftUI

let nightlyTasks = [
    "Check all windows",
    "Check all doors",
    "Check that the safe is locked",
    "Check the mailbox",
    "Inspect security cameras",
    "Clear ice from sidewalks",
    "Document \"strange and unusual\" occurences"
]

let weeklyTasks = [
    "Check inside all vacant rooms",
    "Walk the perimeter of property"
]

let monthlyTasks = [
    "Test security alarm",
    "Test motion detectors",
    "Test smoke alarms"
]

struct ContentView: View {
    @State var theTask = Task(name: "Check all windows", isComplete: false, lastCompleted: nil)
    var body: some View {
        VStack{
            HStack{
                Image(systemName: theTask.isComplete ? "checkmark.square" : "square")
                Text(theTask.name)
            }
            ControlPanel(theTask: self.$theTask)
        }
        
//        NavigationView {
//            List {
//                Section(header: TaskSectionHeader(symbolSystemName: "moon.stars", headerText: "Nightly Tasks")) {
//                    ForEach(nightlyTasks, id: \.self, content: {
//                        taskName in
//                        NavigationLink(taskName,
//                                       destination: DetailsView(task: taskName))
//                    })
//                }
//
//                Section(header: TaskSectionHeader(symbolSystemName: "sunset", headerText: "Weekly Tasks")) {
//                    ForEach(weeklyTasks, id: \.self, content: {
//                        taskName in
//                        NavigationLink(taskName,
//                                       destination: DetailsView(task: taskName))
//                    })
//                }
//                Section(header: TaskSectionHeader(symbolSystemName: "calendar", headerText: "Monthly Tasks")) {
//                    ForEach(monthlyTasks, id: \.self, content: {
//                        taskName in
//                        NavigationLink(taskName,
//                                       destination: DetailsView(task: taskName))
//                    })
//                }
//            }.listStyle(GroupedListStyle())
//            .navigationTitle("Home")
//        }
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
        ContentView()
    }
}

struct ControlPanel: View {
    @Binding var theTask: Task
    
    var body: some View {
        HStack{
            if theTask.isComplete == false{
                Button(action: {
                    theTask.isComplete = true
                }) {
                    Text("Mark Complete")
                }.padding(.top)
            } else {
                Button(action: {
                    theTask.isComplete = false
                }) {
                    Text("Reset")
                }.padding(.top)
            }
        }
    }
}
