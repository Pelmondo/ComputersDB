//
//  ComputerCard.swift
//  ComputersDB
//
//  Created by Сергей Прокопьев on 20.03.2020.
//  Copyright © 2020 PelmondoProd. All rights reserved.
//

import Foundation

struct ComputerCard: Decodable {
        let id: Int
        let name: String
        var introduced: String?
        var discounted: String?
        let imageUrl: String?
        let company: Company?
        let description: String
}

