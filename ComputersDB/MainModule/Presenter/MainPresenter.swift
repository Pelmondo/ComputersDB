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
    func sucsses()
    func failure(_ error: Error)
    func notConnection()
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func getComputers()
    func conectionCheck()
    func getSerchedComputers(computerName: String?)
    var computers: Computers? { get set }
    var page: Int { get set }
    var items: [Items] { get set }
    var searchedItems: [Items] { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol!
    var computers: Computers?
    var page: Int = 0
    var items = [Items]()
    var searchedItems = [Items]()
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getComputers()
    }
    
    func getSerchedComputers(computerName: String?) {
        networkService.getSearchedComp(computerName: computerName) {[weak self] result in
            guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let computers):
                        self.items = computers!.items
                        self.view?.sucsses()
                    case .failure(let error):
                        self.view?.failure(error)
                       }
                   }
               }
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
    
    func conectionCheck() {
            if ReachabilityService.isConnectedToNetwork() == true {
            } else {
                self.view?.notConnection()
            }
    }
}
