//
//  ViewController.swift
//  ComputersDB
//
//  Created by Сергей Прокопьев on 19.03.2020.
//  Copyright © 2020 PelmondoProd. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.estimatedRowHeight = 42
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.backgroundColor = .white
        bar.searchBarStyle = .minimal
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    var presenter: MainViewPresenterProtocol!
    private let cellId = "Cell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.conectionCheck()
        view.backgroundColor = .white
        navigationItem.title = "Computers"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(searchBar)
        view.addSubview(tableView)
        setUpLayout()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ComputerCell.self, forCellReuseIdentifier: cellId)
        
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let companyName = presenter.items[indexPath.row]
        if let cell = cell as? ComputersCellProtocol {
            cell.computerName = companyName.name
            cell.companyName = companyName.company?.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
        let computer = presenter.items[indexPath.row]
        let computerCardVC = ModuleBuilder.createComputerCardModule(computerId: computer.id)
        navigationController?.pushViewController(computerCardVC, animated: true)
        computerCardVC.navigationItem.title = presenter.items[indexPath.row].name
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRow = indexPath.row
        let itemsCount = presenter.items.count
        if lastRow == itemsCount - 1 {
            presenter.page += 1
            presenter.getComputers()
        }
    }
}

extension MainViewController: MainViewProtocol {
    func sucsses() {
        tableView.reloadData()
    }
    
    func failure(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func notConnection() {
        let alert = UIAlertController(title: nil, message: "Internet connections failed!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
        }))
        self.present(alert,animated: true, completion: nil)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.getSerchedComputers(computerName: searchBar.text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.presenter.page = 0
        self.presenter.items = [Items]()
        self.presenter.getComputers()
        self.searchBar.text = ""
        self.searchBar.showsCancelButton = false
        tableView.reloadData()
        self.searchBar.resignFirstResponder()
    }
}

extension MainViewController {
    fileprivate func setUpLayout() {
        let constraints = [
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
