//
//  DetailsView.swift
//  NightWatch
//
//  Created by Tom Stahl on 12/26/22.
//

import SwiftUI

struct DetailsView: View {
    let task: String
    var body: some View {
        VStack {
            Text(task)
            Text("Placeholder 1")
            Text("Placeholder 3")
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(task: "Test")
    }
}
