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
        
        var isInit: Bool = false
        var detailModel: ResultModel? = nil
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
        
        // TEST
        case initTest
        case refreshModelData(genderType: Gender)
        case clickProfile(model: ResultModel)
        
        case deleteRow(Gender, Int)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .initTest:
                state.isInit = true
                return .run { send in
                    await send(.getUser(viewType: .male))
                    await send(.getUser(viewType: .female))
                }
                
            case .clickProfile(let model):
                state.detailModel = model
                return .none
                
            case .refreshModelData(let gender):
                if gender == .male {
                    return .run { send in
                        await send(.getUser(viewType: .male))
                    }
                } else {
                    return .run { send in
                        await send(.getUser(viewType: .female))
                    }
                }
                
            case .clickMale:
                return .run { send in
                    await send(.getUser(viewType: .male))
                }
                
            case .clickFemale:
                return .run { send in
                    await send(.getUser(viewType: .female))
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
                        await send(.getFemale(
                            TaskResult {
                                try await self.randomUserClient.userList(PersonInfo(gender: .female, page: 1))
                            }
                        ))
                    }
                }
            case .moreMale:
                return .run { [state = state] send in
                    await send(.addMale(
                        TaskResult {
                            try await self.randomUserClient.userList(PersonInfo(gender: .male, page: state.maleCount + 1))
                        }
                    ))
                }
            case .moreFemale:
                return .run { [state = state] send in
                    await send(.addFemale(
                        TaskResult {
                            try await self.randomUserClient.userList(PersonInfo(gender: .female, page: state.femaleCount + 1))
                        }
                    ))
                }
            case .getMale(.success(let list)):
                print("getMale = \(list)")
                state.males = list
                state.maleCount = 1
                return .none
            case .getFemale(.success(let list)):
                print("getFemale = \(list)")
                state.females = list
                state.femaleCount = 1
                return .none
            case .addMale(.success(let list)):
                state.males += list
                state.maleCount += 1
                return .none
            case .addFemale(.success(let list)):
                state.females += list
                state.femaleCount += 1
                return .none
            case .deleteRow(let gender, let row):
                if gender == .male {
                    state.males.remove(at: row)
                } else {
                    state.females.remove(at: row)
                }
                return .none
            default:
                return .none
            }
        }
    }
}
