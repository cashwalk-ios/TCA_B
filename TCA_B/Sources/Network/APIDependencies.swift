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

// DependencyValues를 확장해서 get set 프로퍼티 구현 -> 이렇게 사용하면 앱 상위로부터 받아와 의존성을 주입하지 않아도 됨, 별도의 Environment 정의할 필요 없음.
// 즉 App.swift 파일에서부터 의존성을 주입 받아 사용하지 않고 원하는 부분에 @Dependency(\.randomUserClient) var randomUserClient와 같이 받아와 사용 가능?
extension DependencyValues {
    var randomUserClient: RandomUserClient {
        get { self[RandomUserClient.self]}
        set { self[RandomUserClient.self] = newValue }
    }
}

// 특정 유형을 DependencyKey를 통해 의존성 관리 시스템에 등록
extension RandomUserClient: DependencyKey {
    static let liveValue = RandomUserClient(
        userList: { personInfo in
            let userService = RandomUserService()
            var bag = Set<AnyCancellable>()
            return try await withCheckedThrowingContinuation { continuation in
                userService.getUsers(gender: personInfo.gender.rawValue, results: 14, page: personInfo.page)
                    .sink(receiveCompletion: { error in
//                        continuation.resume(returning: [])
                        print("error = \(error)")
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
