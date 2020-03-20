//
//  ComputerCell.swift
//  ComputersDB
//
//  Created by Сергей Прокопьев on 20.03.2020.
//  Copyright © 2020 PelmondoProd. All rights reserved.
//

import Foundation
import UIKit

protocol ComputersCellProtocol: class {
    var computerName: String? { get set }
    var companyName: String? {get set}
}

class ComputerCell: UITableViewCell, ComputersCellProtocol{
    let nameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .italicSystemFont(ofSize: 16)
        label.text = "name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let computerNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let companyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .italicSystemFont(ofSize: 16)
        label.text = "company name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let computerCompanyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "test"
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var computerName: String? {
        didSet {
            guard let name = computerName else { return }
            computerNameLabel.text = name
        }
    }
    
    var companyName: String? {
        didSet {
            if self.companyName != nil {
                addSubview(companyLabel)
                addSubview(computerCompanyLabel)
                computerCompanyLabel.text = self.companyName
                setUpNewLayout(activate: true)
            } else {
                setUpNewLayout(activate: false)
                companyLabel.removeFromSuperview()
                computerCompanyLabel.removeFromSuperview()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        addSubview(computerNameLabel)
        setUpLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
        computerName = nil
        companyName = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ComputerCell {
    func setUpLayout() {
        let constraints = [
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: computerNameLabel.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                constant: -16),
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                               constant: 16),
            
            computerNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
        computerNameLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor,                                       constant: -8),
            computerNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                               constant: -16),
            computerNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                              constant: 16),
    ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setUpNewLayout(activate: Bool) {
        let constraints = [
            companyLabel.topAnchor.constraint(equalTo: computerNameLabel.bottomAnchor,
                                              constant: 8),
            companyLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                   constant: -16),
            companyLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                  constant: 16),
            
            computerCompanyLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor),
            computerCompanyLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                           constant: -16),
            computerCompanyLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                          constant: 16),
            computerCompanyLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                                         constant: -8),
        ]
        activate ? NSLayoutConstraint.activate(constraints) : NSLayoutConstraint.deactivate(constraints)
    }
}
