//
//  WeightQuestionViewController.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import UIKit

class WeightQuestionViewController: UIViewController {
    
    weak var viewFrom        : AHWQuestionView?
    
    private var weightSlider = UISlider()
    private var welcomeLabel = UILabel()
    private var doneButton   = UIButton()
    private var resultWeight = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewFrom?.weightQuestionPopVC = self
        
        setupViews()
    }
    
    deinit {
        print("WeightQuestionViewController is dead")
    }
}

// MARK: - Setup Views
extension WeightQuestionViewController {
    
    private func setupViews() {
        setupWelcomeLabel()
        setupWeightSlider()
        setupDoneButton()
    }
    
    private func setupWelcomeLabel() {
        welcomeLabelConstraints()
        
        welcomeLabel.text = "Вес в кг"
        welcomeLabel.font = .boldSystemFont(ofSize: 30)
        welcomeLabel.textColor = .systemRed
        welcomeLabel.textAlignment = .center
    }
    
    private func welcomeLabelConstraints() {
        view.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupWeightSlider() {
        weightSliderConstraints()
        
        weightSlider.maximumValue = 150
        weightSlider.minimumValue = 40
        weightSlider.value = 60
        weightSlider.minimumTrackTintColor = .systemRed
        weightSlider.thumbTintColor = .systemRed
        
        weightSlider.addTarget(self, action: #selector(sliderAction(sender:)), for: .valueChanged)
    }
    
    private func weightSliderConstraints() {
        view.addSubview(weightSlider)
        weightSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weightSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            weightSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            weightSlider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            weightSlider.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    private func setupDoneButton() {
        doneButtonlConstraints()
        
        let config = UIImage.SymbolConfiguration(pointSize: 31, weight: .bold, scale: .large)
        let largeCheck = UIImage(systemName: "checkmark.circle", withConfiguration: config)
        doneButton.configuration = .filled()
        doneButton.configuration?.baseBackgroundColor = .systemRed
        doneButton.configuration?.baseForegroundColor = .systemBackground
        doneButton.configuration?.image = largeCheck
        doneButton.configuration?.cornerStyle = .capsule
        doneButton.addTarget(self, action: #selector(doneButtonAction(sender:)), for: .touchUpInside)
    }
    
    private func doneButtonlConstraints() {
        view.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            doneButton.heightAnchor.constraint(equalToConstant: 40),
            doneButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}

// MARK: - Actions
extension WeightQuestionViewController {
    
    @objc private func doneButtonAction(sender: UIButton) {
        let label = self.viewFrom?.getWeightButtonTitle()
        dismiss(animated: true) {
            if let user = self.viewFrom?.viewToController?.user {
                self.viewFrom?.updateWeightButton(text: "\(self.resultWeight)", titleColor: .gray, font: .boldSystemFont(ofSize: 20))
                user.setupWeight(weight: self.resultWeight)
                
                if label == "Не определен..." {
                    self.viewFrom?.viewToController?.progressView.setProgress((self.viewFrom?.viewToController?.progressView.progress ?? 0) + 1/6, animated: true)
                    self.viewFrom?.viewToController?.progressCounter += 1/6
                }
                
                print(user.weight!)
            } else {
                print("nil")
            }
        }
    }
    
    @objc private func sliderAction(sender: UISlider) {
        resultWeight = Int(sender.value)
        welcomeLabel.text = "\(Int(sender.value))"
    }

    
}

