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
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .showOptionTapped(let showOption):
                state.showOption = showOption
                return .none
                
            case .switchGender(let gender):
                if gender == .male {
                    state.selectedGender = .male
                } else {
                    state.selectedGender = .female
                }
                return .none
            }
        }
    }
}
