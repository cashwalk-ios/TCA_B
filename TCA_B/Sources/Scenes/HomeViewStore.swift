//
//  ViewStore.swift
//  TCA_B
//
//  Created by 김광록 on 2023/08/29.
//

import ComposableArchitecture

enum GenderTab: String, CaseIterable {
    case male = "남자"
    case female = "여자"
}

struct HomeViewStore: Reducer {
    
    struct State {
        var showOption: ShowOption = .second
        var selectedGender: GenderTab = .male
    }
    
    enum Action {
        case showOptionTapped(ShowOption)
        case switchGender(GenderTab)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .showOptionTapped(showOption):
            state.showOption = showOption
            return .none
            
        case let .switchGender(gender):
            state.selectedGender = gender
            return .none
            
        }
    }
    
}
