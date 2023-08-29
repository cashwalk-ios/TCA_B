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
    
    static let store = Store(initialState: HomeViewStore.State(), reducer: {
        HomeViewStore()
    })
    
    var body: some Scene {
        WindowGroup {
            HomeView(store: TCA_BApp.store)
        }
    }
}
