//
//  FriendsCell.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import UIKit


class FriendsCell: UITableViewCell {
    
// MARK: - Private Properties
    private let avatarView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()
    
    private let resultView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    private let avatarImageView = UIImageView()
    private let resultImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
}

// MARK: - Public Methods
extension FriendsCell {
    
    func configureView(friend: Friend) {
        avatarImageView.image = friend.avatar
        resultImageView.image = friend.resultImage
        nameLabel.text        = friend.name
        descriptionLabel.text = friend.resultBreed
    }
    
}


// MARK: - Private Methods
extension FriendsCell {
    
    private func setupCell() {

        [avatarView, nameLabel, descriptionLabel, resultView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        resultImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.addSubview(avatarImageView)
        resultView.addSubview(resultImageView)
        
        NSLayoutConstraint.activate([
            avatarView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarView.heightAnchor.constraint(equalToConstant: 50),
            avatarView.widthAnchor.constraint(equalToConstant: 50),
            
            resultView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            resultView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            resultView.heightAnchor.constraint(equalToConstant: 50),
            resultView.widthAnchor.constraint(equalToConstant: 50),
            
            avatarImageView.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor),
            avatarImageView.topAnchor.constraint(equalTo: avatarView.topAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor),
            
            resultImageView.leadingAnchor.constraint(equalTo: resultView.leadingAnchor),
            resultImageView.trailingAnchor.constraint(equalTo: resultView.trailingAnchor),
            resultImageView.topAnchor.constraint(equalTo: resultView.topAnchor),
            resultImageView.bottomAnchor.constraint(equalTo: resultView.bottomAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: -8),
            nameLabel.heightAnchor.constraint(equalToConstant: 22),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: -8),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        avatarView.contentMode      = .scaleAspectFill
        resultImageView.contentMode = .scaleAspectFit
    }
}


