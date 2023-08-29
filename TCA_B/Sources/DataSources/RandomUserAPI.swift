//
//  RandomUserAPI.swift
//  TCA_B
//
//  Created by Minhyun Cho on 2023/08/27.
//

import Foundation
import Moya

enum RandomUserAPI {
    case getMaleList
    case getFemaleList
}

extension RandomUserAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://randomuser.me/api")!
    }
    
    var path: String {
        switch self {
        default:
            return "/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMaleList:
            return .requestParameters(
                parameters: [
                    "inc": "gender,name,email,picture,location",
                    "results" : "30",
                    "gender": "male"],
                encoding: URLEncoding.default
            )
        case .getFemaleList:
            return .requestParameters(
                parameters: [
                    "inc": "gender,name,email,picture,location",
                    "results" : "30",
                    "gender":"female"],
                encoding: URLEncoding.default
            )
        }
//        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}

