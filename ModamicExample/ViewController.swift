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
        presenter.configuration.modalWidth = .parentFactor(0.8)
        presenter.configuration.animatedTransition = .bottom
        let updateViewController = UpdateViewController()
        presenter.presentModal(viewController: updateViewController, on: self, completion: nil)
    }
    
    @objc private func handleLoginButton() {
        presenter.configuration.modalVerticalPosition = .bottom
        presenter.configuration.modalWidth = .parentFactor(0.9)
        presenter.configuration.animatedTransition = .bottom
        
        let loginViewController = LoginViewController()
        presenter.presentModal(viewController: loginViewController, on: self, completion: nil)
    }
    
    @objc private func handleMessageButton() {
        presenter.configuration.modalVerticalPosition = .top
        presenter.configuration.modalWidth = .fixed(250)
        presenter.configuration.animatedTransition = .top
        
        let newMessageViewController = NewMessageViewController()
        presenter.presentModal(viewController: newMessageViewController, on: self, completion: nil)
    }
}
