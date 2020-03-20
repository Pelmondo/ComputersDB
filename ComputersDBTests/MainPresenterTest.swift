//
//  MainPresenterTest.swift
//  ComputersDBTests
//
//  Created by Сергей Прокопьев on 20.03.2020.
//  Copyright © 2020 PelmondoProd. All rights reserved.
//

import XCTest
@testable import ComputersDB

class MockView: MainViewProtocol {
    func sucsses() {
    }
    
    func failure(_ error: Error) {
    }
    
    func notConnection() {
    }
}

class MockNetworkService: NetworkServiceProtocol {
    var computers: Computers!
    var computerCard: ComputerCard!
    
    init() {}
    
    convenience init(computer: Computers?, computerCard: ComputerCard?) {
        self.init()
        self.computers = computer
        self.computerCard = computerCard
    }
    
    func getComputersList(page: Int, completion: @escaping (Result<Computers?, Error>) -> Void) {
        if let computers = computers {
            completion(.success(computers))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
    
    func getComputerCard(computerId: Int, completion: @escaping (Result<ComputerCard?, Error>) -> Void) {
        if let computerCard = computerCard {
            completion(.success(computerCard))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
    
    func getSimilarComputers(computerId: Int, completion: @escaping (Result<[Items]?, Error>) -> Void) {
    }
    
    func getSearchedComp(computerName: String?, completion: @escaping (Result<Computers?, Error>) -> Void) {
    }
}

class MainPresenterTest: XCTestCase {
    
    var view: MockView!
    var networkService: NetworkServiceProtocol!
    var presenter: MainPresenter!
    var computer: Computers!
    
    override func setUp() {
        
    }

    override func tearDown() {
        view = nil
        presenter = nil
        networkService = nil
    }
    
    func testGetSucssesComputers() {
        let items = Items(id: 0, name: "Bazz", company: nil)
        let computer = Computers(items: [items], page: 0)
        view = MockView()
        networkService = MockNetworkService(computer: computer, computerCard: nil)
        presenter = MainPresenter(view: view, networkService: networkService)
        
        var catchComputer: Computers?
        
        networkService.getComputersList(page: 0) { result in
            switch result {
            case .success(let computer):
                catchComputer = computer
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        XCTAssertEqual(computer.items.count, catchComputer?.items.count)
    }
    
    func testGetComputerCard() {
            let computerCard = ComputerCard(id: 0, name: "Baz", introduced: nil, discounted: nil, imageUrl: nil, company: nil, description: "Bar")
            view = MockView()
            networkService = MockNetworkService(computer: nil, computerCard: computerCard)
            presenter = MainPresenter(view: view, networkService: networkService)
            
            var catchComputerCard: ComputerCard?
            
            networkService.getComputerCard(computerId: 0) { result in
                switch result {
                case .success(let computer):
                    catchComputerCard = computer
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        XCTAssertEqual(computerCard.name, catchComputerCard?.name)
    }
}
