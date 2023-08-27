//
//  Person.swift
//  TCA_B
//
//  Created by 이아림 on 2023/08/24.
//
  
import Foundation

public enum ViewType: String {
    case female = "여자"
    case male = "남자"

//    public func convertGender() -> Gender {
//        switch self {
//            case .female:
//                return .female
//            case .male:
//                return .male
//        }
//    }
}

//public enum Gender: String, Codable {
//    case female
//    case male
//}

public enum CellType: Equatable {
    case one
    case two
}
struct UserDataModel: Codable, Equatable {
    let results: [ResultModel]
    let info: InfoModel
}

struct InfoModel: Codable, Equatable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}

public struct ResultModel: Codable, Equatable, Identifiable, Hashable {
    public static func == (lhs: ResultModel, rhs: ResultModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    struct NameModel: Codable, Equatable {
        let title: String
        let first: String
        let last: String
    }
    struct LocationModel: Codable, Equatable {
        let street: StreetModel
        let city: String
        let state: String
        let country: String
//        let postcode: Int
//        let coordinates: CoordinatesModel
//        let timezone: TimezoneModel
    }
    struct StreetModel: Codable, Equatable {
        let number: Int
        let name: String
    }
    
    struct CoordinatesModel: Codable, Equatable {
        
        let latitude: String
        let longitude: String
    }
    struct TimezoneModel: Codable, Equatable {
        let offset: String
        let description: String
    }
    struct LoginModel: Codable, Equatable {
        let uuid: String
        let username: String
        let password: String
        let salt: String
        let md5: String
        let sha1: String
        let sha256: String
    }
    struct DobModel: Codable, Equatable {
        let date: String
        let age: Int
    }
    struct RegisteredModel: Codable, Equatable {
        let date: String
        let age: Int
    }
    struct IdModel: Codable, Equatable {
        let name: String
        let value: String?
    }
    
    struct PictureModel: Codable, Equatable {
        let large: String
        let medium: String
        let thumbnail: String
    }
    
    public let id: String
    let gender: String
    let name: NameModel
    let location: LocationModel
    let email: String
    let login: LoginModel
    let dob: DobModel
    let registered: RegisteredModel
    let phone: String
    let cell: String
    let idModel: IdModel
    let picture: PictureModel
    let nat: String
    
}

