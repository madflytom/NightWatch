//
//  NightWatchApp.swift
//  NightWatch
//
//  Created by Tom Stahl on 12/24/22.
//

import SwiftUI

@main
struct NightWatchApp: App {
    @StateObject private var nightWatchTasks = NightWatchTasks()
    var body: some Scene {
        WindowGroup {
            ContentView(nightWatchTasks: nightWatchTasks)
                
        }
    }
}
