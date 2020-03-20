//
//  Computers.swift
//  ComputersDB
//
//  Created by Сергей Прокопьев on 19.03.2020.
//  Copyright © 2020 PelmondoProd. All rights reserved.
//

import Foundation

struct Computers: Decodable {
    let items: [Items]
    let page: Int
}

struct Items: Decodable {
    let id: Int
    let name: String
    let company: Company?
}

struct Company: Decodable {
    let id: Int?
    let name: String?
}
