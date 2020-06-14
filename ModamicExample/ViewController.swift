//
//  ViewController.swift
//  ModamicExample
//
//  Created by Daniel Horvath on 04.06.20.
//  Copyright © 2020 Daniel Horvath. All rights reserved.
//

import UIKit
import Modamic

class ViewController: UIViewController {
    
    private let containerStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.spacing = 20
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private let updateButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Show update", for: .normal)
        return $0
    }(UIButton(type: .system))
    
    private let loginButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Login", for: .normal)
        return $0
    }(UIButton(type: .system))
    
    private let messageButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("New message", for: .normal)
        return $0
    }(UIButton(type: .system))
    
    private let presenter = DynamicContentSizePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        updateButton.addTarget(self, action: #selector(handleUpdateButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(handleMessageButton), for: .touchUpInside)
        
        containerStackView.addArrangedSubview(loginButton)
        containerStackView.addArrangedSubview(updateButton)
        containerStackView.addArrangedSubview(messageButton)
        
        view.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([containerStackView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
                                     containerStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                                     containerStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)])
    }
    
    @objc private func handleUpdateButton() {
        presenter.configuration.modalVerticalPosition = .center
        presenter.configuration.modalWidth = .fixed(125)
        
        let updateViewController = UpdateViewController()
        
        presenter.presentModal(viewController: updateViewController, on: self, completion: nil)
    }
    
    @objc private func handleLoginButton() {
        presenter.configuration.modalVerticalPosition = .bottom
        presenter.configuration.modalWidth = .parentFactor(0.9)
        
        let loginViewController = LoginViewController()
        
        presenter.presentModal(viewController: loginViewController, on: self, completion: nil)
    }
    
    @objc private func handleMessageButton() {
        presenter.configuration.modalVerticalPosition = .top
        presenter.configuration.modalWidth = .fixed(250)
        
        let newMessageViewController = NewMessageViewController()
        
        presenter.presentModal(viewController: newMessageViewController, on: self, completion: nil)
    }
}

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
            $0.isHidden = false
            return $0
        }(UILabel())
        
        private let changelogLabel: UILabel = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = UIFont.systemFont(ofSize: 17)
            $0.text = "A changelog is a log or record of all notable changes made to a project. The project is often a website or software project, and the changelog usually includes records of changes such as bug fixes, new features, etc. Some open-source projects include a changelog as one of the top-level files in their distribution."
//            $0.isScrollEnabled = false
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.isHidden = false
            return $0
        }(UILabel())
        
        private let changelogButton: UIButton = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.blue.withAlphaComponent(0.6)
            
            let attributedTitle = NSAttributedString(string: "Changelog", attributes: [.foregroundColor : UIColor.white])
            $0.setAttributedTitle(attributedTitle, for: .normal)
            $0.isHidden = true
            return $0
        }(UIButton(type: .system))
        
        private let closeButton: UIButton = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.setTitle("Not now", for: .normal)
            $0.isHidden = true
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
            changelogLabel.isHidden = false
            
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

class LoginViewController: UIViewController {
    private let containerStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.spacing = 10
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private let loginButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor.purple.withAlphaComponent(0.7)
        
        let attributedTitle = NSAttributedString(string: "Login", attributes: [.foregroundColor : UIColor.white])
        $0.setAttributedTitle(attributedTitle, for: .normal)
        return $0
    }(UIButton(type: .system))
    
    private let usernameTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Username"
        return $0
    }(UITextField())
    
    private let passwordTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Password"
        $0.isSecureTextEntry = true
        return $0
    }(UITextField())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.layer.cornerRadius = 10
        view.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        view.backgroundColor = .white
        
        containerStackView.addArrangedSubview(usernameTextField)
        containerStackView.addArrangedSubview(passwordTextField)
        containerStackView.addArrangedSubview(loginButton)
        
        view.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([containerStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                                     containerStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                                     containerStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                                     containerStackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
                                     
                                     usernameTextField.heightAnchor.constraint(equalToConstant: 50),
                                     passwordTextField.heightAnchor.constraint(equalToConstant: 50),
                                     
                                     loginButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                                     loginButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                                     loginButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }
}

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
