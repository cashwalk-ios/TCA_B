//
//  ListViewStore.swift
//  TCA_B
//
//  Created by 이아림 on 2023/08/27.
//

import ComposableArchitecture
import Dependencies
import Combine
import SwiftUI

public struct ListViewStore: Reducer {
     
    @Dependency(\.randomUserClient) var randomUserClient
    public struct State: Equatable {
        var maleCount: Int = 0
        var femaleCount: Int = 0
        var males: [ResultModel] = []
        var females: [ResultModel] = []
        var viewType: ViewType = .male
        var cellType: CellType = .one
        var maleRefreshLoading: Bool = false
        var femaleRefreshLoading: Bool = false
        var isLoadingNextPageMale: Bool = false
        var isLoadingNextPageFemale: Bool = false
    }
    
    public enum Action: Equatable {
        case clickMale
        case clickFemale
        case clickCellMode
        case getUser(viewType: ViewType)
        case getMale(TaskResult<[ResultModel]>)
        case getFemale(TaskResult<[ResultModel]>)
        case moreMale
        case addMale(TaskResult<[ResultModel]>)
        case moreFemale
        case addFemale(TaskResult<[ResultModel]>)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .clickMale:
                return .run { send in
                    await send(.getUser(viewType: .male))
                }
            case .getUser(let viewType):
                if viewType == .male {
                    return .run { send in
                        await send(.getMale(
                            TaskResult {
                                try await self.randomUserClient.userList(PersonInfo(gender: .male, page: 1))
                            }
                        ))
                    }
                } else {
                    return .run { send in
                        await send(.getMale(
                            TaskResult {
                                try await self.randomUserClient.userList(PersonInfo(gender: .female, page: 1))
                            }
                        ))
                    }
                }
            case .getMale(.success(let list)):
                print("getMale = \(list)")
                state.males = list
                return .none
            case .getFemale(.success(let list)):
                print("getFemale = \(list)")
                state.females = list
                return .none
            default:
                return .none
            }
        }
    }
}
