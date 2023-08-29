//
//  UserModel.swift
//  TCA_B
//
//  Created by Minhyun Cho on 2023/08/27.
//

import Foundation


// gender,name,email,picture,location

struct UserModel: Decodable {
    let gender: Gender?
    let name: String?
    let email: String?
    let picture: URL?
    let location: String?
}
