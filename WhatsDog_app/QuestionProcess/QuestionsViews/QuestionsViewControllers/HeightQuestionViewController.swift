//
//  HeightQuestionViewController.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import UIKit

class HeightQuestionViewController: UIViewController {
    
    weak var viewFrom        : AHWQuestionView?
    
    private var heightSlider = UISlider()
    private var welcomeLabel = UILabel()
    private var doneButton   = UIButton()
    
    private var resultHeight = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewFrom?.heightQuestionPopVC = self
        
        setupViews()
    }
    
    deinit {
        print("HeightQuestionViewController is dead")
    }
}

// MARK: - Setup Views
extension HeightQuestionViewController {
    
    private func setupViews() {
        setupWelcomeLabel()
        setupHeightSlider()
        setupDoneButton()
    }
    
    private func setupWelcomeLabel() {
        welcomeLabelConstraints()
        
        welcomeLabel.text = "Рост в см"
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
    
    private func setupHeightSlider() {
        heightSliderConstraints()
        
        heightSlider.maximumValue = 220
        heightSlider.minimumValue = 80
        heightSlider.value = 150
        heightSlider.minimumTrackTintColor = .systemRed
        heightSlider.thumbTintColor = .systemRed
        
        heightSlider.addTarget(self, action: #selector(sliderAction(sender:)), for: .valueChanged)
    }
    
    private func heightSliderConstraints() {
        view.addSubview(heightSlider)
        heightSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            heightSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            heightSlider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            heightSlider.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupDoneButton() {
        doneButtonConstraints()
        
        let config = UIImage.SymbolConfiguration(pointSize: 31, weight: .bold, scale: .large)
        let largeCheck = UIImage(systemName: "checkmark.circle", withConfiguration: config)
        doneButton.configuration = .filled()
        doneButton.configuration?.baseBackgroundColor = .systemRed
        doneButton.configuration?.baseForegroundColor = .systemBackground
        doneButton.configuration?.image = largeCheck
        doneButton.configuration?.cornerStyle = .capsule
        
        doneButton.addTarget(self, action: #selector(doneButtonAction(sender:)), for: .touchUpInside)
    }
    
    private func doneButtonConstraints() {
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
extension HeightQuestionViewController {
    
    @objc private func doneButtonAction(sender: UIButton) {
        let label = self.viewFrom?.getHeightButtonTitle()
        dismiss(animated: true) {
            if let user = self.viewFrom?.viewToController?.user {
                
                self.viewFrom?.updateHeightButton(text: "\(self.resultHeight)", titleColor: .gray, font: .boldSystemFont(ofSize: 20))
                user.setupHeight(height: self.resultHeight)
                
                if label == "Не определен..." {
                    self.viewFrom?.viewToController?.progressView.setProgress((self.viewFrom?.viewToController?.progressView.progress ?? 0) + 1/6, animated: true)
                    self.viewFrom?.viewToController?.progressCounter += 1/6
                }
                
                print(user.height!)
            } else {
                print("nil")
            }
        }
    }
    
    @objc private func sliderAction(sender: UISlider) {
        resultHeight = Int(sender.value)
        welcomeLabel.text = "\(Int(sender.value))"
    }

    
}

