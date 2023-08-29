//
//  TCA_BApp.swift
//  TCA_B
//
//  Created by 이아림 on 2023/08/08.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_BApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(store: Store(initialState: ListViewStore.State(), reducer: {
                ListViewStore()
            }))
        }
    }
}
