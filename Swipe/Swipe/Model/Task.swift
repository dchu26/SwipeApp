//
//  Task.swift
//  Swipe
//
//  Created by David Chu on 8/3/23.
//

import SwiftUI

struct Task: Identifiable{
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}

struct TaskMetaData: Identifiable{
    var id = UUID().uuidString
    var task: [Task]
    var taskDate: Date
}

func getSampleDate(offset: Int)->Date{
    let calendar = Calendar.current
    
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

var tasks: [TaskMetaData] = [

    TaskMetaData(task: [
        Task(title: "Available"),
        Task(title: "Available"),
        Task(title: "Available")
    ], taskDate: getSampleDate(offset: 1)),
    TaskMetaData(task: [
        Task(title: "Available"),
        Task(title: "Available"),
        Task(title: "Available")
    ], taskDate: getSampleDate(offset: 5)),
    TaskMetaData(task: [
        Task(title: "Available"),
        Task(title: "Available"),
        Task(title: "Available")
    ], taskDate: getSampleDate(offset: 12)),
    TaskMetaData(task: [
        Task(title: "Available"),
        Task(title: "Available"),
        Task(title: "Available")
    ], taskDate: getSampleDate(offset: 17)),
    TaskMetaData(task: [
        Task(title: "Available"),
        Task(title: "Available"),
        Task(title: "Available")
    ], taskDate: getSampleDate(offset: 19)),
    TaskMetaData(task: [
        Task(title: "Available"),
        Task(title: "Available"),
        Task(title: "Available")
    ], taskDate: getSampleDate(offset: 20)),
    TaskMetaData(task: [
        Task(title: "Available"),
        Task(title: "Available"),
        Task(title: "Available")
    ], taskDate: getSampleDate(offset: 22)),
    TaskMetaData(task: [
        Task(title: "Available"),
        Task(title: "Available"),
        Task(title: "Available")
    ], taskDate: getSampleDate(offset: 25)),
    TaskMetaData(task: [
        Task(title: "Available"),
        Task(title: "Available"),
        Task(title: "Available")
    ], taskDate: getSampleDate(offset: 27)),
    TaskMetaData(task: [
        Task(title: "Available"),
        Task(title: "Available"),
        Task(title: "Available")
    ], taskDate: getSampleDate(offset: 28)),
    
    
]
