//
//  ListViewStore.swift
//  TCA_B
//
//  Created by Minhyun Cho on 2023/08/22.
//

import SwiftUI
import ComposableArchitecture
import Moya

struct ListViewStore: Reducer {
    
    private let provider = MoyaProvider<RandomUserAPI>()
    
    struct State: Equatable {
        @BindingState var isComplete = false
    }
    
    enum Action: Equatable {
        case onAppear
        case manTapRefresh
        case womanTapRefresh
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                self.requestAPI()
                return .none
            case .manTapRefresh:
                return .none
            case .womanTapRefresh:
                self.requestAPI()
                return .none
            }
        }
    }
    
    private func requestAPI() {
        self.provider.request(.getMaleList, completion: { result in
            switch result {
            case .success(let response):
                let data = try? JSONDecoder().decode(UserListResponse.self, from: response.data)
                print(data)
                
            case .failure(let error):
                print("Error - \(error)")
                
            }
        })
    }
    
//    func reduce(into state: inout State, action: Action) -> Effect<Action> {
//
//    }
    // case-studies integration
}
