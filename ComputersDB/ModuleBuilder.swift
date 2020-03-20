//
//  ModuleBuilder.swift
//  ComputersDB
//
//  Created by Сергей Прокопьев on 19.03.2020.
//  Copyright © 2020 PelmondoProd. All rights reserved.
//

import Foundation
import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createComputerCardModule(computerId: Int?) -> UIViewController
}

class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let networkService = NetworkService()
        let view = MainViewController()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    static func createComputerCardModule(computerId: Int?) -> UIViewController {
        let view = ComputerCardView()
        let networkService = NetworkService()
        let presenter = ComputerCardPresenter(view: view, networkService: networkService, computerId: computerId)
        view.presenter = presenter
        return view
    }
}
