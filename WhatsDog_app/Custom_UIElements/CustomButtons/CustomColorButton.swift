//
//  CustomColorButton.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import UIKit

class CustomColorButton: UIButton {
    
    private(set) var mainColor: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    convenience init(mainColor: UIColor) {
        self.init()
        setupWithColor(color: mainColor)
        print("Button init with \(mainColor)")
    }
    
    deinit {
        print("Button dead")
    }
    
    private func setupButton() {
        
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        // layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
        clipsToBounds = true
        setShadow()
    }
    
    func setupWithColor(color: UIColor) {
        setupButton()
        backgroundColor = color
    }
    
    func setShadowColor() {
        layer.shadowColor    = UIColor.systemGreen.cgColor
        layer.shadowOffset   = CGSize(width: 0.0, height: 3.0)
        layer.shadowRadius   = 4
        layer.shadowOpacity  = 0.5
        clipsToBounds        = true
        layer.masksToBounds  = false
    }
    
    private func setShadow() {
        layer.shadowColor    = UIColor.black.cgColor
        layer.shadowOffset   = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius   = 2
        layer.shadowOpacity  = 0.2
        clipsToBounds        = true
        layer.masksToBounds  = false
    }
    
}

