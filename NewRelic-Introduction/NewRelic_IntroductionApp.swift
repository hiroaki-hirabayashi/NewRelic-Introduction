//
//  NewRelic_IntroductionApp.swift
//  NewRelic-Introduction
//
//  Created by Hiroaki-Hirabayashi on 2022/06/03.
//

import SwiftUI
import NewRelic

@main
struct NewRelic_IntroductionApp: App {
    let persistenceController = PersistenceController.shared

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            MainView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        NewRelic.start(withApplicationToken:"")

        return true
    }
}
