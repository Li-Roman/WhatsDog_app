//
//  CustomButton.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super .init(frame: frame)
         setupButton()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setupButton()
    }
    
    func setupButton() {
        setShadow()
        setTitleColor(.white, for: .normal)
        setTitleColor(.systemGray3, for: .highlighted)
        setTitleShadowColor(.gray, for: .highlighted)
        
        backgroundColor      = .systemRed
        titleLabel?.font     = UIFont(name: "AvenirNext-DemiBold", size: 25)
        layer.cornerRadius   = 10
        // layer.borderWidth    = 1.0
        // layer.borderColor    = UIColor.darkGray.cgColor
    }
    
    private func setShadow() {
        layer.shadowColor    = UIColor.black.cgColor
        layer.shadowOffset   = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius   = 8
        layer.shadowOpacity  = 0.5
        clipsToBounds        = true
        layer.masksToBounds  = false
    }
    
    func shake() {
        let shake            = CABasicAnimation(keyPath: "position")
        shake.duration       = 0.1
        shake.repeatCount    = 1
        shake.autoreverses   = true
        
        let fromPoint        = CGPoint(x: center.x, y: center.y + 3)
        let fromValue        = NSValue(cgPoint: fromPoint)
        
        let toPoint          = CGPoint(x: center.x, y: center.y - 3)
        let toValue          = NSValue(cgPoint: toPoint)
        
        shake.fromValue      = fromValue
        shake.toValue        = toValue
        
        layer.add(shake, forKey: "position")
    }
}
