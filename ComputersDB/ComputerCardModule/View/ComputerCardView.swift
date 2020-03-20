//
//  ComputerCardView.swift
//  ComputersDB
//
//  Created by Сергей Прокопьев on 20.03.2020.
//  Copyright © 2020 PelmondoProd. All rights reserved.
//

import Foundation
import UIKit

class ComputerCardView: UIViewController {
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let activityInd : UIActivityIndicatorView = {
         let active = UIActivityIndicatorView()
         active.color = .black
         active.backgroundColor = .white
         active.translatesAutoresizingMaskIntoConstraints = false
         return active
     }()
    
    let computerImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.backgroundColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let extendButton: UIButton = {
        let button = UIButton()
        button.setTitle("tap to extand", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(tapButton(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    private var isButtonPressed = false
    @objc func tapButton(sender: UIButton) {
        labelViews.computerDiscriptLabel.numberOfLines = isButtonPressed ? 3 : .max
        extendButton.setTitle(isButtonPressed ? "tap to extend" : "tap to zip", for: .normal)
        isButtonPressed = isButtonPressed ? false : true
    }
    
    @objc func linkButtonTap(sender: UIButton) {
        let nextVC = ModuleBuilder.createComputerCardModule(computerId: sender.tag)
        nextVC.navigationItem.title = sender.title(for: .normal)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    var presenter: ComputerCardPresenterProtocol!
    let labelViews = ComputerCardLabelViews()
    
    var imageGet: UIImage? {
        didSet {
            if self.imageGet != nil {
                self.computerImage.image = self.imageGet
                self.activityInd.stopAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getComputerCard()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        setUpScrollV()
        setUpLayout()
        activityInd.startAnimating()
    }
}

extension ComputerCardView: ComputerCardViewProtocol {
    func sucsses() {
        labelViews.computerNameLabel.text = presenter.computerCard?.name
        labelViews.computerIntroDateLabel.text = presenter.computerCard?.introduced
        labelViews.computerDiscountLabel.text = presenter.computerCard?.discounted
        labelViews.computerDiscriptLabel.text = presenter.computerCard?.description
        presenter.getImage()
    }
    
    func failure(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func getLinks() {
        let button = UIButton()
        button.setTitle(presenter.computerLinks?.name, for: .normal)
        button.addTarget(self, action: #selector(linkButtonTap(sender:)), for: .touchUpInside)
        button.tag = presenter.computerLinks!.id
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(button)
    }
}

//MARK:-Layout Settings
extension ComputerCardView {
    fileprivate func setUpScrollV() {
           scrollView.addSubview(computerImage)
           scrollView.addSubview(labelViews.nameLabel)
           scrollView.addSubview(labelViews.computerNameLabel)
           scrollView.addSubview(labelViews.introDateLabel)
           scrollView.addSubview(labelViews.computerIntroDateLabel)
           scrollView.addSubview(labelViews.discontDateLabel)
           scrollView.addSubview(labelViews.discriptionLabel)
           scrollView.addSubview(labelViews.computerDiscountLabel)
           scrollView.addSubview(labelViews.computerDiscriptLabel)
           scrollView.addSubview(extendButton)
           scrollView.addSubview(activityInd)
           scrollView.addSubview(labelViews.previewLabel)
           scrollView.addSubview(stackView)
       }
    
    fileprivate func setUpLayout() {
                let constraints = [
                    view.topAnchor.constraint(equalTo: scrollView.topAnchor),
                    view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                    scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    
                    computerImage.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                                       constant: 8),
                    computerImage.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor,
                                                        constant: 64),
                    computerImage.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor,
                                                        constant: -64),
                    computerImage.heightAnchor.constraint(equalTo: computerImage.widthAnchor),
                    //activity indicator
                    activityInd.topAnchor.constraint(equalTo: computerImage.topAnchor),
                    activityInd.bottomAnchor.constraint(equalTo: computerImage.bottomAnchor),
                    activityInd.trailingAnchor.constraint(equalTo: computerImage.trailingAnchor),
                    activityInd.leadingAnchor.constraint(equalTo: computerImage.leadingAnchor),
                    //nameLabel
                    labelViews.nameLabel.topAnchor.constraint(equalTo: computerImage.bottomAnchor,
                                                   constant: 32),
                    labelViews.nameLabel.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor,
                                                    constant: -32),
                    labelViews.nameLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: 16),
                    labelViews.nameLabel.bottomAnchor.constraint(equalTo: labelViews.computerNameLabel.topAnchor),
                    //ComputernameLabel
                    labelViews.computerNameLabel.topAnchor.constraint(equalTo: labelViews.nameLabel.bottomAnchor),
                    labelViews.computerNameLabel.leadingAnchor.constraint(equalTo:
                        scrollView.safeAreaLayoutGuide.leadingAnchor,constant: 16),
                    labelViews.computerNameLabel.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -32),
                    //intoDateLable
                    labelViews.introDateLabel.topAnchor.constraint(equalTo: labelViews.computerNameLabel.bottomAnchor,
                                                        constant: 8),
                    labelViews.introDateLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor,
                                                            constant: 16),
                    labelViews.introDateLabel.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -32),
                    //computerIntoDate
                    labelViews.computerIntroDateLabel.topAnchor.constraint(equalTo: labelViews.introDateLabel.bottomAnchor),
                    labelViews.computerIntroDateLabel.leadingAnchor.constraint(equalTo:
                        scrollView.safeAreaLayoutGuide.leadingAnchor,constant: 16),
                    labelViews.computerIntroDateLabel.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -32),
                    //DiscountDate
                    labelViews.discontDateLabel.topAnchor.constraint(equalTo: labelViews.computerIntroDateLabel.bottomAnchor,
                                                        constant: 8),
                    labelViews.discontDateLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor,
                                                            constant: 16),
                    labelViews.discontDateLabel.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -32),
                    //ComputerDiscount lable
                    labelViews.computerDiscountLabel.topAnchor.constraint(equalTo: labelViews.discontDateLabel.bottomAnchor),
                    labelViews.computerDiscountLabel.leadingAnchor.constraint(equalTo:
                        scrollView.safeAreaLayoutGuide.leadingAnchor,constant: 16),
                    labelViews.computerDiscountLabel.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -32),
                    //discription label
                    labelViews.discriptionLabel.topAnchor.constraint(equalTo: labelViews.computerDiscountLabel.bottomAnchor,
                                                        constant: 8),
                    labelViews.discriptionLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor,
                                                            constant: 16),
                    labelViews.discriptionLabel.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -32),
                    labelViews.computerDiscriptLabel.topAnchor.constraint(equalTo: labelViews.discriptionLabel.bottomAnchor),
                    labelViews.computerDiscriptLabel.leadingAnchor.constraint(equalTo:
                        scrollView.safeAreaLayoutGuide.leadingAnchor,constant: 16),
                    labelViews.computerDiscriptLabel.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                    labelViews.computerDiscriptLabel.bottomAnchor.constraint(equalTo: extendButton.topAnchor,
                                                                  constant: -5),
                    //button
                    extendButton.topAnchor.constraint(equalTo: labelViews.computerDiscriptLabel.bottomAnchor,
                                                      constant: 5),
                    extendButton.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor,
                                                           constant: -16),
    //                extendButton.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: -16),
                    //previewLabel
                    labelViews.previewLabel.topAnchor.constraint(equalTo: extendButton.bottomAnchor, constant: 5),
                    labelViews.previewLabel.trailingAnchor.constraint(lessThanOrEqualTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                    labelViews.previewLabel.leadingAnchor.constraint(greaterThanOrEqualTo: scrollView.leadingAnchor,
                                                          constant: 16),
                    labelViews.previewLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                    // stack View
                    stackView.topAnchor.constraint(equalTo: labelViews.previewLabel.bottomAnchor,
                                                   constant: 8),
                    stackView.leadingAnchor.constraint(greaterThanOrEqualTo: scrollView.safeAreaLayoutGuide.leadingAnchor,
                                                       constant: 16),
                    stackView.trailingAnchor.constraint(lessThanOrEqualTo: scrollView.trailingAnchor,
                                                        constant: -16),
                    stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                    stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,
                                                      constant: -16),
                ]
                NSLayoutConstraint.activate(constraints)
            }
}
