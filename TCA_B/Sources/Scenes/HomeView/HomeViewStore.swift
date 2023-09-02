//
//  ViewStore.swift
//  TCA_B
//
//  Created by 김광록 on 2023/08/29.
//

import ComposableArchitecture

public enum Gender: String, Equatable {
    case male
    case female
}

struct HomeViewStore: Reducer {
    
    struct State: Equatable {
        var showOption: ShowOption = .second
        var selectedTab: String = Gender.male.rawValue
        var selectedGender: Gender = .male  
    }
    
    enum Action: Equatable {
        case showOptionTapped(ShowOption)
        case switchGender(Gender)
        case switchTab(String)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .showOptionTapped(showOption):
            state.showOption = showOption
            return .none
            
        case let .switchTab(gender):
            if gender == Gender.male.rawValue {
                state.selectedGender = .male
            } else {
                state.selectedGender = .female
            }
            return .none

        case let .switchGender(gender):
            state.selectedGender = gender
            return .none
            
        }
    }
    
}