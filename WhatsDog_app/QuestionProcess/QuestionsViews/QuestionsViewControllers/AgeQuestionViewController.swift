//
//  AgeQuestionViewController.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import UIKit

class AgeQuestionViewController: UIViewController {
    
    weak var viewFrom        : AHWQuestionView?
    
    private var welcomeLabel = UILabel()
    private var datePicker   = UIDatePicker()
    private var doneButton   = CustomButton()

    private var years        = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewFrom?.ageQuestionPopVC = self
        
        view.backgroundColor = .systemBackground
        setupViews()
    }
   
    deinit {
        print("AgeQuestionViewController is dead")
    }
   
}

// MARK: - Setup Views
extension AgeQuestionViewController {
    
    private func setupViews() {
        setupWelcomeLabel()
        setupDatePicker()
        setupDoneButton()
    }
    
    private func setupWelcomeLabel() {
        welcomeLabelConstrainrs()
        
        welcomeLabel.text = "Когда вылез?"
        welcomeLabel.font = .boldSystemFont(ofSize: 30)
        welcomeLabel.textColor = .systemRed
        welcomeLabel.textAlignment = .center
    }
    
    private func welcomeLabelConstrainrs() {
        view.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupDatePicker() {
        datePickerConstraints()
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.minimumDate = Date(timeIntervalSinceNow: -100*365*24*60*60)
        datePicker.maximumDate = .now
        datePicker.addTarget(self, action: #selector(datePickerAction(sender:)), for: .valueChanged)
    }
    
    private func datePickerConstraints() {
        view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 10)
        ])
    }
    
    private func setupDoneButton() {
        doneButtonConstraints()
        
        doneButton.setTitle("DONE", for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonDidTapped(sender:)), for: .touchUpInside)
    }
    
    private func doneButtonConstraints() {
        view.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            doneButton.centerXAnchor.constraint(equalTo: datePicker.centerXAnchor),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            doneButton.heightAnchor.constraint(equalToConstant: 40),
            doneButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}

// MARK: - Private Methods
extension AgeQuestionViewController {
    
    private func switchAge(_ age: Int) -> String {
        
        guard age < 10 || age > 20 else { return "лет" }
        
        let lastNumber = age % 10
        
        switch lastNumber {
        case 1:
            return "год"
        case 2...4:
            return "года"
        default:
            return "лет"
        }
    }
}

// MARK: - Button Actions
extension AgeQuestionViewController {
    
    @objc
    private func doneButtonDidTapped(sender: UIButton) {
        if let user = viewFrom?.viewToController?.user {
            if user.age == nil {
                viewFrom?.viewToController?.progressView.setProgress((viewFrom?.viewToController?.progressView.progress ?? 0) + 1/6, animated: true)
                viewFrom?.viewToController?.progressCounter += 1/6
            }
            user.setupAge(age: years)
            print(user.age!)
        } else {
            print("nil")
        }
        
        viewFrom?.updateAgeButton(text: " \(years) \(switchAge(years))", titleColor: .gray, font: .boldSystemFont(ofSize: 20))
        
        dismiss(animated: true)
    }

    @objc
    private func datePickerAction(sender: UIDatePicker) {
        years = Int(-sender.date.timeIntervalSinceNow/(60*60*24*365))
    }
}

