//
//  BaseAPI.swift
//  TCA_B
//
//  Created by 이아림 on 2023/08/27.
//

import Foundation
import Moya
import CombineMoya
import Combine

enum RandomUser {
    case getUsers(String, Int, Int)
}

extension RandomUser: TargetType {
    var baseURL: URL {
        URL(string: "https://randomuser.me/api/")!
    }
    
    var path: String {
        switch self {
        case .getUsers: return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUsers: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getUsers(let gender, let results, let page):
            var params: [String: Any] = [:]
            params.updateValue(gender, forKey: "gender")
            params.updateValue(results, forKey: "results")
            params.updateValue(page, forKey: "page")
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        [:]
    }
    
}

class RandomUserService {
    
    let provider = MoyaProvider<RandomUser>()
    
    init() {}
    
    
    func getUsers(gender: String = "male", results: Int = 1, page: Int = 1) -> AnyPublisher<UserDataModel, Error> {
        
        return provider.requestPublisher(.getUsers(gender, results, page))
            .tryMap { response in
                let data = try JSONDecoder().decode(UserDataModel.self, from: response.data)
                return data
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
}
