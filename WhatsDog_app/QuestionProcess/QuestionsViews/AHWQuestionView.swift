//
//  AHWQuestionView.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import UIKit

class AHWQuestionView: CustomUIView {
    
    var ageQuestionPopVC     : AgeQuestionViewController?
    var heightQuestionPopVC  : HeightQuestionViewController?
    var weightQuestionPopVC  : WeightQuestionViewController?
     
    weak var viewToController: DataFillingViewController?
    
    private var welcomeLabel = UILabel()
    private var ageLabel     = UILabel()
    private var heightLabel  = UILabel()
    private var weightLabel  = UILabel()
    
    private var ageButton    = UIButton()
    private var heightButton = UIButton()
    private var weightButton = UIButton()
    
    
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
        
        viewToController?.awhQuestionView = self
        setupViews()

    }
    
    deinit {
        print("AHWQuestionView is dead")
    }
}

// MARK: - Internal Methods
extension AHWQuestionView {
    
    func getWelcomeLabelText() -> String? {
        welcomeLabel.text
    }
    
    func updateWelcomeLabel(text: String) {
        welcomeLabel.text = text
    }
    
    func getAgeButtonTitle() -> String? {
        ageButton.titleLabel?.text
    }
    
    func getHeightButtonTitle() -> String? {
        heightButton.titleLabel?.text
    }
    
    func getWeightButtonTitle() -> String? {
        weightButton.titleLabel?.text
    }
    
    func updateAgeButton(text: String, titleColor: UIColor = .systemGray4, font: UIFont = .italicSystemFont(ofSize: 20)) {
        ageButton.setTitle(text, for: .normal)
        ageButton.setTitleColor(titleColor, for: .normal)
        ageButton.titleLabel?.font = font
    }
    
    func updateHeightButton(text: String, titleColor: UIColor = .systemGray4, font: UIFont = .italicSystemFont(ofSize: 20)) {
        heightButton.setTitle(text, for: .normal)
        heightButton.setTitleColor(titleColor, for: .normal)
        heightButton.titleLabel?.font = font
    }
    
    func updateWeightButton(text: String, titleColor: UIColor = .systemGray4, font: UIFont = .italicSystemFont(ofSize: 20) ) {
        weightButton.setTitle(text, for: .normal)
        weightButton.setTitleColor(titleColor, for: .normal)
        weightButton.titleLabel?.font = font
    }
    
}

// MARK: - Setup Views
extension AHWQuestionView {
    
    private func setupViews() {
        setupWelcomeLabel()
        setupQuestionLabels()
        setupQuestionButtons()
    }
    
    private func setupWelcomeLabel() {
        
        addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            welcomeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            welcomeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        welcomeLabel.text = "Заполни данные!"
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont(name: "Helvetica", size: 25)
        welcomeLabel.numberOfLines = 2
        welcomeLabel.textColor = .systemRed
    }
    
    private func setupQuestionLabels() {
        makeLabelsConstraints()
        setupLabels()
    }
    
    private func makeLabelsConstraints() {
        
        [ageLabel, heightLabel, weightLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            ageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            ageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            ageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 170),
            ageLabel.heightAnchor.constraint(equalToConstant: 40),
            
            heightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            heightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            heightLabel.topAnchor.constraint(equalTo: topAnchor, constant: 270),
            heightLabel.heightAnchor.constraint(equalToConstant: 40),
            
            weightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            weightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            weightLabel.topAnchor.constraint(equalTo: topAnchor, constant: 370),
            weightLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupLabels() {
        
        [ageLabel, heightLabel, weightLabel].forEach {
            $0.text = "Ваш возраст"
            $0.textColor = .systemRed
            $0.textAlignment = .left
            $0.font = UIFont(name: "Helvetica", size: 20)
        }

    }
    
    private func setupQuestionButtons() {
        makeButtonsConstraints()
        setupButtons()
    }
    
    private func makeButtonsConstraints() {
        [ageButton, heightButton, weightButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            ageButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            ageButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            ageButton.topAnchor.constraint(equalTo: topAnchor, constant: 210),
            ageButton.heightAnchor.constraint(equalToConstant: 30),
            
            heightButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            heightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            heightButton.topAnchor.constraint(equalTo: topAnchor, constant: 310),
            heightButton.heightAnchor.constraint(equalToConstant: 30),
            
            weightButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            weightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            weightButton.topAnchor.constraint(equalTo: topAnchor, constant: 410),
            weightButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        ageButton.addTarget   (viewToController, action: #selector(ageButtonAction(sender:)),    for: .touchUpInside)
        heightButton.addTarget(viewToController, action: #selector(heightButtonAction(sender:)), for: .touchUpInside)
        weightButton.addTarget(viewToController, action: #selector(weigthButtonAction(sender:)), for: .touchUpInside)
    }
    
    private func setupButtons() {
        [ageButton, heightButton, weightButton].forEach {
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            $0.setTitle("Не определен...", for: .normal)
            $0.setTitleColor(.systemGray4, for: .normal)
            $0.contentHorizontalAlignment = .left
            $0.titleLabel?.font = .italicSystemFont(ofSize: 20)
            $0.layer.cornerRadius = 5
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.systemGray5.cgColor
        }
    }
}

// MARK: - Button Actions
extension AHWQuestionView {
    
    @objc func ageButtonAction(sender: UIButton) {

        let vc = AgeQuestionViewController()
        vc.viewFrom = self
        if let bottomVC = vc.sheetPresentationController {
            bottomVC.detents = [.medium()/*, .large()*/]
            bottomVC.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        viewToController?.present(vc, animated: true)
    }
    
    @objc func heightButtonAction(sender: UIButton) {
        
        let popVC = HeightQuestionViewController()
        popVC.viewFrom = self
        popVC.modalPresentationStyle = .popover
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self.viewToController!
        popOverVC?.sourceView = self.heightButton
        popOverVC?.sourceRect = CGRect(x: self.heightButton.bounds.midX, y: self.heightButton.bounds.maxY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: bounds.width, height: 140)
        viewToController?.present(popVC, animated: true )
    }
    
    @objc func weigthButtonAction(sender: UIButton) {
        let popVC = WeightQuestionViewController()
        popVC.viewFrom = self
        popVC.modalPresentationStyle = .popover
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self.viewToController!
        popOverVC?.sourceView = self.weightButton
        popOverVC?.sourceRect = CGRect(x: self.heightButton.bounds.midX, y: self.heightButton.bounds.minY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: bounds.width, height: 140)
        viewToController?.present(popVC, animated: true )
    }
}

