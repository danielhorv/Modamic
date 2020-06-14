//
//  LoginViewController.swift
//  ModamicExample
//
//  Created by Daniel Horvath on 14.06.20.
//  Copyright © 2020 Daniel Horvath. All rights reserved.
//

import UIKit

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
