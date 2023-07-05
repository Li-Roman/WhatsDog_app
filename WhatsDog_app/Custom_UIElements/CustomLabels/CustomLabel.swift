//
//  CustomLabel.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import UIKit

class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel()
    }
    
    func setupLabel() {
        layer.backgroundColor = UIColor.systemGray6.cgColor
        layer.cornerRadius = 20
        textAlignment = .center
        numberOfLines = 0
        font = UIFont(name: "Helvetica", size: 60)
        font = .boldSystemFont(ofSize: 60)
        textColor = .systemRed
    }
    
}

