//
//  NewRelic_IntroductionApp.swift
//  NewRelic-Introduction
//
//  Created by Hiroaki-Hirabayashi on 2022/06/03.
//

import SwiftUI

@main
struct NewRelic_IntroductionApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
