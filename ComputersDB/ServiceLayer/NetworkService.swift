//
//  NetworkService.swift
//  ComputersDB
//
//  Created by Сергей Прокопьев on 19.03.2020.
//  Copyright © 2020 PelmondoProd. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func getComputersList(page: Int, completion: @escaping (Result<Computers?, Error>) -> Void)
    func getComputerCard(computerId: Int, completion: @escaping (Result<ComputerCard?, Error>) -> Void)
    func getSimilarComputers(computerId: Int, completion: @escaping (Result<[Items]?, Error>) -> Void)
    func getSearchedComp(computerName: String?, completion: @escaping (Result<Computers?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getComputersList(page:Int, completion: @escaping (Result<Computers?, Error>) -> Void) {
        let urlString = "http://testwork.nsd.naumen.ru/rest/computers?p=\(page)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let obj = try JSONDecoder().decode(Computers.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
        
    func getComputerCard(computerId: Int, completion: @escaping (Result<ComputerCard?, Error>) -> Void) {
        let urlString = "http://testwork.nsd.naumen.ru/rest/computers/\(computerId)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let obj = try JSONDecoder().decode(ComputerCard.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getSimilarComputers(computerId: Int, completion: @escaping (Result<[Items]?, Error>) -> Void) {
        let urlString = "http://testwork.nsd.naumen.ru/rest/computers/\(computerId)/similar"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let obj = try JSONDecoder().decode([Items].self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getSearchedComp(computerName: String?, completion: @escaping (Result<Computers?, Error>) -> Void) {
        let urlString = "http://testwork.nsd.naumen.ru/rest/computers?f=" + (computerName ?? "")
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let obj = try JSONDecoder().decode(Computers.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
