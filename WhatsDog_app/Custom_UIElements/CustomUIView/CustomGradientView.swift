//
//  CustomGradientView.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import UIKit

class CustomGradientView: UIView {
    
    enum Point {
        case topLeading
        case leading
        case bottomLeading
        case top
        case center
        case bottom
        case topTrailing
        case trailing
        case bottomTrailing
        
        var point: CGPoint {
            switch self {
            case .topLeading     : return CGPoint(x: 0,     y: 0)
            case .leading        : return CGPoint(x: 0,     y: 0.5)
            case .bottomLeading  : return CGPoint(x: 0,     y: 1.0)
            case .top            : return CGPoint(x: 0.5,   y: 0)
            case .center         : return CGPoint(x: 0.5,   y: 0.5)
            case .bottom         : return CGPoint(x: 0.5,   y: 1)
            case .topTrailing    : return CGPoint(x: 1,     y: 0)
            case .trailing       : return CGPoint(x: 1,     y: 0.5)
            case .bottomTrailing : return CGPoint(x: 1,     y: 1)
            }
        }
    }
    
    private let gradientLayer = CAGradientLayer()
    private var colors = [UIColor]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    convenience init(colors: [UIColor]) {
        self.init()
        self.colors = colors
        setupGradient(with: colors)
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
         gradientLayer.frame = bounds
    }
    
    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.white.cgColor, UIColor.systemRed.cgColor]
        gradientLayer.startPoint = Point.bottomLeading.point
        gradientLayer.endPoint = Point.topTrailing.point
    }
    
    private func setupGradient(with colors: [UIColor]) {
        self.layer.addSublayer(gradientLayer)
        gradientLayer.colors = colors.map {$0.cgColor}
        self.colors = colors
    }
    
    func setupGradientColors(with colors: [UIColor]) {
        setupGradient(with: colors)
    }
    
    func getColors() -> [UIColor] {
        return colors
    }
}

