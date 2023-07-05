//
//  HairColorQuestionView.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import UIKit

class HairColorQuestionView: CustomUIView {
    
    weak var viewToController: DataFillingViewController?
    
    private var welcomeLabel        = UILabel()
    private var colorCircle         = CustomGradientView(colors: [.systemRed, .systemGreen])
    
    private var colorsStack         = UIStackView()
    private var firstColorsStack    = UIStackView()
    private var secondColorStack    = UIStackView()
    
    private var firstStackSubViews  = [UIView]()
    private var secondStackSubViews = [UIView]()
    private var colorsStackSubViews = [UIView]()
    
    private var whiteButton         = CustomColorButton(mainColor: UIColor.HairColor.whiteColor)
    private var goldButton          = CustomColorButton(mainColor: UIColor.HairColor.goldColor)
    private var lightBrownButton    = CustomColorButton(mainColor: UIColor.HairColor.lightBrown)
    private var redHairButton       = CustomColorButton(mainColor: UIColor.HairColor.redHairColor)
    private var brownButton         = CustomColorButton(mainColor: UIColor.HairColor.brownColor)
    private var darkBrownButton     = CustomColorButton(mainColor: UIColor.HairColor.darkBrownColor)
    private var blackButton         = CustomColorButton(mainColor: UIColor.HairColor.blackColor)
    private var grayButton          = CustomColorButton(mainColor: UIColor.HairColor.grayColor)
    
    private var buttons             = [CustomColorButton]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func setupView() {
        super.setupView()
        
        viewToController?.hairColorQuestionView = self
        
        setupViews()
    }
    
    deinit {
        print("HairColorQuestionView is dead")
    }
}

// MARK: - Setup Views
extension HairColorQuestionView {
    
    private func setupViews() {
        setupWelcomeLabel()
        setupColorCircle()
        setupStackViews()
//        setupButtons()
    }
    
    private func setupWelcomeLabel() {
        welcomeLabelConstraints()
        
        welcomeLabel.text = "ЧЕМ КРАСИШЬСЯ?"
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont(name: "Helvetica", size: 30)
        welcomeLabel.numberOfLines = 2
        welcomeLabel.textColor = .systemRed
        
    }
    
    private func welcomeLabelConstraints() {
        addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            welcomeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            welcomeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupColorCircle() {
        colorCircleConstraints()
        
        colorCircle.layer.cornerRadius = 125
        colorCircle.layer.masksToBounds = true
    }
    
    private func colorCircleConstraints() {
        addSubview(colorCircle)
        colorCircle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorCircle.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorCircle.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            colorCircle.heightAnchor.constraint(equalToConstant: 250),
            colorCircle.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setupStackViews() {
        
        buttons             = [whiteButton, goldButton, lightBrownButton, redHairButton, brownButton, darkBrownButton, blackButton, grayButton]
        firstStackSubViews  = [whiteButton, goldButton, lightBrownButton, redHairButton]
        secondStackSubViews = [brownButton, darkBrownButton, blackButton, grayButton]
        
        firstColorsStack    = UIStackView(arrangedSubviews: firstStackSubViews)
        secondColorStack    = UIStackView(arrangedSubviews: secondStackSubViews)
        colorsStackSubViews = [firstColorsStack, secondColorStack]
        colorsStack         = UIStackView(arrangedSubviews: colorsStackSubViews)
        
        colorsStack.axis               = .vertical
        colorsStack.alignment          = .fill
        colorsStack.distribution       = .fillEqually
        colorsStack.spacing            = 20
         
        [firstColorsStack, secondColorStack].forEach {
            $0.axis                    = .horizontal
            $0.alignment               = .fill
            $0.distribution            = .fillEqually
            $0.spacing                 = 20
        }
        
        setupButtons(buttons: buttons)
        stackViewConstraints()
    }
    
    private func stackViewConstraints() {
        addSubview(colorsStack)
        colorsStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorsStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            colorsStack.widthAnchor.constraint(equalToConstant: 260),
            colorsStack.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupButtons(buttons: [UIButton]) {
        for button in buttons {
            button.layer.cornerRadius = 25
        }
        addButtonTargets()
    }
}

// MARK: - Button Actions
extension HairColorQuestionView {
    
    private func addButtonTargets() {
        for button in buttons {
            button.addTarget(viewToController, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        }
    }
    
    @objc
    private func buttonAction(sender: CustomColorButton) {
        
        if checkCircleColors() {
            viewToController?.progressView.setProgress((viewToController?.progressView.progress ?? 0) + 1/6, animated: true)
            self.viewToController?.progressCounter += 1/5
        }
        
        if let color = sender.backgroundColor {
            switch color {
            case UIColor.HairColor.whiteColor     : colorCircle.setupGradientColors(with: [UIColor.HairColor.whiteColor,     .lightGray])    ; viewToController?.user.setupHairColor(hairColor: .white)
            case UIColor.HairColor.goldColor      : colorCircle.setupGradientColors(with: [UIColor.HairColor.goldColor,      .systemYellow]) ; viewToController?.user.setupHairColor(hairColor: .gold)
            case UIColor.HairColor.lightBrown     : colorCircle.setupGradientColors(with: [UIColor.HairColor.lightBrown,     .systemBrown])  ; viewToController?.user.setupHairColor(hairColor: .lightBrown)
            case UIColor.HairColor.redHairColor   : colorCircle.setupGradientColors(with: [UIColor.HairColor.redHairColor,   .systemOrange]) ; viewToController?.user.setupHairColor(hairColor: .redHairColor)
            case UIColor.HairColor.brownColor     : colorCircle.setupGradientColors(with: [UIColor.HairColor.brownColor,     .systemBrown])  ; viewToController?.user.setupHairColor(hairColor: .brown)
            case UIColor.HairColor.darkBrownColor : colorCircle.setupGradientColors(with: [UIColor.HairColor.darkBrownColor, .systemBrown])  ; viewToController?.user.setupHairColor(hairColor: .darkBrown)
            case UIColor.HairColor.blackColor     : colorCircle.setupGradientColors(with: [UIColor.HairColor.blackColor,     .darkGray])     ; viewToController?.user.setupHairColor(hairColor: .black)
            case UIColor.HairColor.grayColor      : colorCircle.setupGradientColors(with: [UIColor.HairColor.grayColor,      .gray])         ; viewToController?.user.setupHairColor(hairColor: .gray)
            default: break
            }
            
            clear()
            sender.alpha = 0.2
        }
    }
}

// MARK: - Private Methods
extension HairColorQuestionView {
    
    private func clear() {
        for button in buttons {
            if button.alpha != 1 {
                button.alpha = 1
            }
        }
    }
    
    private func checkCircleColors() -> Bool {
        let colors = colorCircle.getColors()
        return colors == [.systemRed, .systemGreen]
    }
}
