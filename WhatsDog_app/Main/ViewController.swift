//
//  ViewController.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 04.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var friendsButton = CustomButton()
    private var welcomeLabel = CustomLabel()
    private var mainBackgroundImage = UIImageView()
    private var startButton = CustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    deinit {
        print("Main ViewController is dead")
    }
}

// MARK: - Private methods
extension ViewController {
    
    private func setupViews() {
        makeConstraints()
        setupBackgroundView()
        setupStartButton()
        setupFrindsButton()
        setupWelcomeLabel()
    }
    
    private func setupBackgroundView() {
        mainBackgroundImage.image = UIImage(named: "mainBackgroundImage")
        mainBackgroundImage.contentMode = .scaleAspectFill
    }
    
    private func setupWelcomeLabel() {
        welcomeLabel.text = "КАКАЯ ТЫ СОБАКА?"
    }
    
    private func setupFrindsButton() {
        friendsButton.setTitle("ДРУЗЬЯ", for: .normal)
        friendsButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        friendsButton.addTarget(self, action: #selector(frindsButtonAction(sender:)), for: .touchUpInside)
    }
    
    private func setupStartButton() {
        startButton.setTitle("УЗНАТЬ", for: .normal)
        startButton.addTarget(self, action: #selector(startButtonAction(sender:)), for: .touchUpInside)
    }
    
    private func makeConstraints() {
        
        [mainBackgroundImage, welcomeLabel, startButton, friendsButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 150),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            startButton.heightAnchor.constraint(equalToConstant: 60),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            
            friendsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            friendsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            friendsButton.heightAnchor.constraint(equalToConstant: 30),
            friendsButton.widthAnchor.constraint(equalToConstant: 100),
            
            mainBackgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainBackgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainBackgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            mainBackgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Button Actions
extension ViewController {
    
    @objc
    private func frindsButtonAction(sender: CustomButton) {
        let vc = FriendsViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true)
    }
    
    @objc
    private func startButtonAction(sender: CustomButton) {
        let vc = DataFillingViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

