//
//  ProfileDetailViewController.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import Foundation
import UIKit

class ProfileDetailViewController: UIViewController {
    
    // MARK: - Private Properties
    private let avatarIcon  = UIImageView()
    private let nameLabel   = UILabel()
    private let resultIcon  = UIImageView()
    private let resultLabel = UILabel()
    private let infoButton  = UIButton()
    private let backView    = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        makeConstraints()
        setupView()
    }
    
    deinit {
        print("ProfileDetailViewController is dead")
    }
}
    
// MARK: - Internal Methods
extension ProfileDetailViewController {
    func setupInfoFor(name: String, avatar: UIImage, resultDescripton: String, resultImage: UIImage) {
        nameLabel.text = name
        resultLabel.text = resultDescripton
        avatarIcon.image = avatar
        resultIcon.image = resultImage
    }
}


// MARK: - SetupViews
extension ProfileDetailViewController {
    
    private func makeConstraints() {
        
        [resultIcon, infoButton, backView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        [avatarIcon, nameLabel, resultLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            backView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
            avatarIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            avatarIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarIcon.heightAnchor.constraint(equalToConstant: 100),
            avatarIcon.widthAnchor.constraint(equalToConstant: 100),
            
            backView.leadingAnchor.constraint(equalTo: avatarIcon.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            backView.heightAnchor.constraint(equalTo: avatarIcon.heightAnchor),
            backView.topAnchor.constraint(equalTo: avatarIcon.topAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarIcon.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            resultLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            resultLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            resultLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            resultIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultIcon.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            resultIcon.heightAnchor.constraint(equalToConstant: 300),
            resultIcon.widthAnchor.constraint(equalToConstant: 300),
            
            infoButton.leadingAnchor.constraint(equalTo: resultIcon.trailingAnchor, constant: -30),
            infoButton.bottomAnchor.constraint(equalTo: resultIcon.topAnchor, constant: 30),
            infoButton.heightAnchor.constraint(equalToConstant: 30),
            infoButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        
    }
    
    private func setupView() {
        setupAvatarIcon()
        setupResultLabel()
        setupNameLabel()
        setupInfoButton()
        setupBackView()
    }
    
    private func setupBackView() {
        backView.backgroundColor = .systemGray6
        backView.layer.cornerRadius = 50
    }
    
    private func setupAvatarIcon() {
        avatarIcon.layer.cornerRadius = 50
        avatarIcon.clipsToBounds = true
        avatarIcon.contentMode = .scaleAspectFill
    }
    
    private func setupNameLabel() {
        nameLabel.font = .boldSystemFont(ofSize: 22)
        nameLabel.sizeToFit()
        nameLabel.textColor = .darkText
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
    }
    
    private func setupResultLabel() {
        resultLabel.font = .italicSystemFont(ofSize: 18)
        resultLabel.textColor = .gray
        resultLabel.textAlignment = .left
        resultLabel.numberOfLines = 0
    }
    
    
    private func setupInfoButton() {
        infoButton.configuration = .gray()
        infoButton.configuration?.baseBackgroundColor = .systemBackground
        infoButton.configuration?.baseForegroundColor = .gray
        infoButton.configuration?.image = UIImage(systemName: "info.circle")
        
        infoButton.setTitleColor(.black, for: .highlighted)
        
        infoButton.addTarget(self, action: #selector(infoButtonAction(sender:)), for: .touchUpInside)
    }
    
    private func findUrl() -> URL? {
        var request: URL?
        for dog in Dogs {
            if dog.name == resultLabel.text {
                request = dog.urlRequest
            }
        }
        return request
    }
}

// MARK: - Actions
extension ProfileDetailViewController {
    
    @objc
    private func infoButtonAction(sender: UIButton) {
        let vc = DogInfoViewController()
        vc.getRequst(url: findUrl())
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

