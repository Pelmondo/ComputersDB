//
//  ComputerCardLabelViews.swift
//  ComputersDB
//
//  Created by Сергей Прокопьев on 20.03.2020.
//  Copyright © 2020 PelmondoProd. All rights reserved.
//

import Foundation
import UIKit

class ComputerCardLabelViews {
    lazy var previewLabel: UILabel = {
           let label = UILabel()
           label.text = "You must be looking"
           label.font = .boldSystemFont(ofSize: 20)
           label.numberOfLines = 0
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name:"
        label.font = .italicSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var computerNameLabel: UILabel = {
         let label = UILabel()
         label.text = ""
         label.font = .boldSystemFont(ofSize: 20)
         label.numberOfLines = 0
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    lazy var introDateLabel: UILabel = {
            let label = UILabel()
            label.text = "introduced date:"
            label.font = .italicSystemFont(ofSize: 16)
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()
    
    lazy var computerIntroDateLabel: UILabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()
    
    lazy var discontDateLabel: UILabel = {
            let label = UILabel()
            label.text = "discontinued date:"
            label.font = .italicSystemFont(ofSize: 16)
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()
    
    
    lazy var computerDiscountLabel: UILabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()
    
    lazy var discriptionLabel: UILabel = {
            let label = UILabel()
            label.text = "discription:"
            label.font = .italicSystemFont(ofSize: 16)
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()
    
    lazy var computerDiscriptLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
