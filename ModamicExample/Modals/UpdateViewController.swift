//
//  UpdateViewController.swift
//  ModamicExample
//
//  Created by Daniel Horvath on 14.06.20.
//  Copyright © 2020 Daniel Horvath. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {
    
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
    
    private let changelogLabel: UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.text = "A changelog is a log or record of all notable changes made to a project. The project is often a website or software project, and the changelog usually includes records of changes such as bug fixes, new features, etc. Some open-source projects include a changelog as one of the top-level files in their distribution."
        $0.isScrollEnabled = false
        $0.isHidden = true
        return $0
    }(UITextView())
    
    private let changelogButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor.blue.withAlphaComponent(0.6)
        
        let attributedTitle = NSAttributedString(string: "Changelog", attributes: [.foregroundColor : UIColor.white])
        $0.setAttributedTitle(attributedTitle, for: .normal)
        return $0
    }(UIButton(type: .system))
    
    private let closeButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Not now", for: .normal)
        return $0
    }(UIButton(type: .system))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        closeButton.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        changelogButton.addTarget(self, action: #selector(handleChangelogButton), for: .touchUpInside)
    }
    
    @objc private func handleClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleChangelogButton() {
        changelogButton.isHidden.toggle()
        changelogLabel.isHidden.toggle()
        
        // Runtime resize the modal
        setPreferredContentSizeFromAutolayout()
    }
    
    private func setupView() {
        view.layer.cornerRadius = 10
        view.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        view.backgroundColor = .white
        
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(changelogLabel)
        containerStackView.addArrangedSubview(changelogButton)
        containerStackView.addArrangedSubview(closeButton)
        
        view.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([containerStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                                     containerStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                                     containerStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                                     containerStackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
                                     
                                     changelogButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                                     changelogButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                                     changelogButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
}
