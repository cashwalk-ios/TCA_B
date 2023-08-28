//
//  APIDependencies.swift
//  TCA_B
//
//  Created by 이아림 on 2023/08/27.
//

import Moya
import ComposableArchitecture
import Combine
import Dependencies
import SwiftUI


struct RandomUserClient {
    var userList: @Sendable(PersonInfo) async throws -> [ResultModel]
}

public struct PersonInfo: Equatable, Sendable  {
    let gender: ViewType
    let page: Int
}

extension DependencyValues {
    var randomUserClient: RandomUserClient {
        get { self[RandomUserClient.self]}
        set { self[RandomUserClient.self] = newValue }
    }
}

extension RandomUserClient: DependencyKey {
    static let liveValue = RandomUserClient(
        userList: { personInfo in
            let userService = RandomUserService()
            var bag = Set<AnyCancellable>()
            return try await withCheckedThrowingContinuation { continuation in
                userService.getUsers(gender: personInfo.gender.rawValue, results: 14, page: personInfo.page)
                    .sink(receiveCompletion: { error in
                        continuation.resume(returning: [])
                    }, receiveValue: { userList in
                        continuation.resume(returning: userList.results)
                    })
                    .store(in: &bag)
            }
        }
    )
}
//extension DependencyValues {
//    var getUser: @Sendable
//}
