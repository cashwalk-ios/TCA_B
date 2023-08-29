//
//  ViewStore.swift
//  TCA_B
//
//  Created by 김광록 on 2023/08/29.
//

import ComposableArchitecture

public enum Gender: String, CaseIterable {
    case male
    case female
}

struct HomeViewStore: Reducer {
    
    struct State {
        var showOption: ShowOption = .second
        var selectedGender: Gender = .male
    }
    
    enum Action {
        case showOptionTapped(ShowOption)
        case switchGender(Gender)
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
