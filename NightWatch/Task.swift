//
//  Task.swift
//  NightWatch
//
//  Created by Tom Stahl on 12/26/22.
//

import Foundation

struct Task : Identifiable{
    let id = UUID()
    let name: String
    var isComplete: Bool
    var lastCompleted: Date? 
}
