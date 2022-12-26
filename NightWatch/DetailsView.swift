//
//  DetailsView.swift
//  NightWatch
//
//  Created by Tom Stahl on 12/26/22.
//

import SwiftUI

struct DetailsView: View {
    @Binding var task: Task
    var body: some View {
        VStack {
            Text(task.name)
            Text("Placeholder 1")
            Button("Mark Complete"){
                task.isComplete = true
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(task: Binding<Task>.constant( Task(name: "Test", isComplete: false, lastCompleted: nil)))
    }
}
