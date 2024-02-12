//
//  NavigationMREApp.swift
//  NavigationMRE
//
//  Created by Daniels Liekmanis on 12/02/2024.
//

import ComposableArchitecture
import SwiftUI

@main
struct NavigationMREApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(
                    initialState: TestFeature.State()
                ) {
                    TestFeature()
                }
            )
        }
    }
}
