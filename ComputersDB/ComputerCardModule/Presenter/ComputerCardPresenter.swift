//
//  ComputerCardPresenter.swift
//  ComputersDB
//
//  Created by Сергей Прокопьев on 20.03.2020.
//  Copyright © 2020 PelmondoProd. All rights reserved.
//

import Foundation
import UIKit

protocol ComputerCardViewProtocol: class {
    func sucsses() // think about realisation  i guess this is logick
    func failure(_ error: Error)
    func getLinks()
    var imageGet: UIImage? { get set }
}

protocol ComputerCardPresenterProtocol: class {
    init(view: ComputerCardViewProtocol, networkService: NetworkServiceProtocol, computerId: Int?)
    func getComputerCard()
    func getImage()
    func getLinksComputers()
    var computerCard: ComputerCard? { get set }
    var computerLinks: Items? {get set}
}

class ComputerCardPresenter: ComputerCardPresenterProtocol {
    weak var view: ComputerCardViewProtocol?
    let networkService: NetworkServiceProtocol!
    var computerId: Int?
    var computerCard: ComputerCard?
    var computerLinks: Items?
    
    
    required init(view: ComputerCardViewProtocol, networkService: NetworkServiceProtocol, computerId: Int?) {
        self.view = view
        self.networkService = networkService
        self.computerId = computerId
        getComputerCard()
        getLinksComputers()
    }
    
    private let dateFormatter = DateFormatter()
    private func dateParse(_ date: String?) -> String {
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        guard let stringDate = date else {return "-"}
        let date = dateFormatter.date(from: stringDate)
        dateFormatter.dateFormat = "dd MMM yyyy"
        guard let myDate = date else {return "-"}
        return dateFormatter.string(from: myDate)
    }
    
    public func getImage() {
        if let stringUrl = computerCard?.imageUrl {
            guard let url = URL(string: stringUrl) else {return}
            let queue = DispatchQueue.global(qos: .utility)
            queue.async{
                do {
                    let data = try Data(contentsOf: url)
                     DispatchQueue.main.async {
                        self.view?.imageGet = UIImage(data: data)!
                    }
                } catch {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self.view?.imageGet = #imageLiteral(resourceName: "placeholder")
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.view?.imageGet = #imageLiteral(resourceName: "placeholder")
            }
        }
    }
    
    public func getLinksComputers() {
        networkService.getSimilarComputers(computerId: computerId!) {[weak self] result in
            guard let self = self else { return }
            var maxCount = 0
            DispatchQueue.main.async {
                switch result {
                case .success(let computerLinks):
                    for comp in computerLinks! {
                        if maxCount != 5 {
                            maxCount += 1
                            self.computerLinks = comp
                            self.view?.getLinks()
                        }
                    }
                    maxCount = 0
                case .failure(let error):
                    self.view?.failure(error)
                }
            }
        }
    }
    
    public func getComputerCard() {
        networkService.getComputerCard(computerId: computerId!) {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let computerCard):
                    self.computerCard = computerCard
                    self.computerCard?.discounted = self.dateParse(computerCard?.discounted)
                    self.computerCard?.introduced = self.dateParse(computerCard?.introduced)
                    self.view?.sucsses()
                case .failure(let error):
                    self.view?.failure(error)
                }
            }
        }
    }
}
