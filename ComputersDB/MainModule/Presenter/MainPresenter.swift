//
//  MainPresenter.swift
//  ComputersDB
//
//  Created by Сергей Прокопьев on 19.03.2020.
//  Copyright © 2020 PelmondoProd. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewProtocol: class {
    func sucsses() // think about realisation  i guess this is logick
    func failure(_ error: Error)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func getComputers()
    var computers: Computers? { get set }
    var page: Int { get set }
    var items: [Items] {get set}
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol!
    var computers: Computers?
    var page: Int = 0
    var items = [Items]()
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getComputers()
    }
    
    func getComputers() {
        networkService.getComputersList(page: page) {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let computers):
                    self.computers = computers
                    self.items += self.computers!.items
                    self.view?.sucsses()
                case .failure(let error):
                    self.view?.failure(error)
                }
            }
        }
    }
}
