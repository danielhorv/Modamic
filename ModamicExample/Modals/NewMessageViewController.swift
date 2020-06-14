//
//  NewMessageViewController.swift
//  ModamicExample
//
//  Created by Daniel Horvath on 14.06.20.
//  Copyright © 2020 Daniel Horvath. All rights reserved.
//

import UIKit

class NewMessageViewController: UIViewController {
   
    private let containerStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.spacing = 10
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textAlignment = .center
        $0.text = "Update available You have a new message"
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let changelogLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.text = "A changelog is a log or record of all notable changes made to a project. The project is often a website or software project, and the changelog usually includes records of changes such as bug fixes, new features, etc. Some open-source projects include a changelog as one of the top-level files in their distribution."
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        return $0
    }(UILabel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.layer.cornerRadius = 10
       
        view.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        view.backgroundColor = .white
        
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(changelogLabel)
        
        view.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([containerStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                                     containerStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                                     containerStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                                     containerStackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)])
    }
}
