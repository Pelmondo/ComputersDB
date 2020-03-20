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
}

    
//    var delegate : ComputersGet?
//    //MARK: - Network
//    var urlComp: URLComponents = {
//        var components = URLComponents()
//        components.scheme = "http"
//        components.host = "testwork.nsd.naumen.ru"
//        return components
//    }()
//
//    var answer = [Items]()
//    private var pageNumber = 0
//
//    //MARK: - Func for another URLs
//    func getUrlForList() -> URL? {
//        urlComp.path = "/rest/computers"
//        urlComp.queryItems = [URLQueryItem(name: "p", value: String(pageNumber))]
//        return urlComp.url
//    }
//
//    func getUrlForCard(_ id: Int) {
//        urlComp.path = "/rest/computers/\(id)"
//        guard let url = urlComp.url else {return}
//        startSession(url: url)
//    }
//
//    func getSearchUrl(_ name: String) {
//        urlComp.path = "/rest/computers"
//        urlComp.queryItems = [URLQueryItem(name: "f", value: name)]
//         guard let url = urlComp.url else {return}
//        startSession(url: url)
//    }
//
//    func getUrlSimilar(_ id: Int) {
//        urlComp.path = "/rest/computers/\(id)/similar"
//        guard let url = urlComp.url else {return}
//        startSession(url: url)
//    }
//
//    func updatePage() {
//        pageNumber += 1
//        print(pageNumber)
//    }
//
//    private func startSession(url: URL) {
//            let session = URLSession.shared
//            session.dataTask(with: url) {(data, response, error) in
////                guard let response = response else {return}
////                    dump(response)
//                guard let data = data else {return}
//                self.delegate?.getComputers(computers: data)
//            }.resume()
//        }
//
//    func getComputersList() {
//        guard let url = getUrlForList() else {return}
//        startSession(url: url)
//    }
//}

