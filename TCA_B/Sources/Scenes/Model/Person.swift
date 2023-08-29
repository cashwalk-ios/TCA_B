//
//  Person.swift
//  TCA_B
//
//  Created by 이아림 on 2023/08/24.
//
  
import Foundation

public enum ViewType: String, Sendable {
    case female
    case male
}
 
public enum CellType: Equatable {
    case one
    case two
}

public struct UserDataModel: Codable, Equatable, Sendable  {
    let results: [ResultModel]
    let info: InfoModel
}

struct InfoModel: Codable, Equatable, Sendable  {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}

public struct ResultModel: Codable, Equatable, Sendable  {
    struct NameModel: Codable, Equatable, Sendable  {
        let title: String
        let first: String
        let last: String
    }
    struct LocationModel: Codable, Equatable, Sendable  {
        let street: StreetModel
        let city: String
        let state: String
        let country: String
//        let postcode: Int
//        let coordinates: CoordinatesModel
//        let timezone: TimezoneModel
    }
    struct StreetModel: Codable, Equatable, Sendable  {
        let number: Int
        let name: String
    }
    
    struct CoordinatesModel: Codable, Equatable, Sendable  {
        
        let latitude: String
        let longitude: String
    }
    struct TimezoneModel: Codable, Equatable, Sendable  {
        let offset: String
        let description: String
    }
    struct LoginModel: Codable, Equatable, Sendable  {
        let uuid: String
        let username: String
        let password: String
        let salt: String
        let md5: String
        let sha1: String
        let sha256: String
    }
    struct DobModel: Codable, Equatable, Sendable  {
        let date: String
        let age: Int
    }
    struct RegisteredModel: Codable, Equatable, Sendable  {
        let date: String
        let age: Int
    }
    struct IdModel: Codable, Equatable, Sendable  {
        let name: String
        let value: String?
    }
    
    struct PictureModel: Codable, Equatable, Sendable  {
        let large: String
        let medium: String
        let thumbnail: String
    }
     
    let gender: String
    let name: NameModel
    let location: LocationModel
    let email: String
    let login: LoginModel
    let dob: DobModel
    let registered: RegisteredModel
    let phone: String
    let cell: String
    let id: IdModel
    let picture: PictureModel
    let nat: String
    
}

