//
//  RemindersApp.swift
//  Reminders
//
//  Created by Victor Deon on 22/05/25.
//

import SwiftUI

@main
struct RemindersApp: App {
    var body: some Scene {
        WindowGroup {
            let viewContext = CoreDataManager.shared.persistentContainer.viewContext
            HomeScreen().environment(\.managedObjectContext, viewContext)
        }
    }
}
