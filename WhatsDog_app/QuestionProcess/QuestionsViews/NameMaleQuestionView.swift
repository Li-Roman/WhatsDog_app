//
//  NameMaleQuestionView.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import UIKit

class NameMaleQuestionView: CustomUIView {
    
    weak var viewToController    : DataFillingViewController?

    private var welcomeLabel     = UILabel()
    private var nameLabel        = UILabel()
    private var maleLabel        = UILabel()
    
    private var nameInputView    = UIView()
    private var maleInputView    = UIView()
    
    private var nameTextField    = UITextField()
    private var maleButton       = UIButton()
    
    
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
        
        viewToController?.nameQuestionView = self
        
        setupViews()
        
    }
    
    deinit {
        print("NameQuestionView dead")
    }
    
}

// MARK: - Setup Views
extension NameMaleQuestionView {
    
    private func setupViews() {
        setupWelcomeLabel()
        setupNameLabel()
        setupNameTextField()
        setupMaleLabel()
        setupMaleButton()
    }
    
    private func setupWelcomeLabel() {
        welcomeLabelConstraints()
        
        welcomeLabel.text = "Давайте знакомиться!"
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
    
    private func setupNameLabel() {
        nameLabelConstraints()
        
        nameLabel.text = "Как вас зовут?"
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont(name: "Helvetica", size: 20)
        nameLabel.textColor = .systemRed
    }
    
    private func nameLabelConstraints() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 120),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupMaleLabel() {
        maleLabelConstraints()
        
        maleLabel.text = "Выберите ваш пол"
        maleLabel.textAlignment = .left
        maleLabel.font = UIFont(name: "Helvetica", size: 20)
        maleLabel.textColor = .systemRed
    }
    
    private func maleLabelConstraints() {
        addSubview(maleLabel)
        maleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            maleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            maleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            maleLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 100),
            maleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupNameTextField() {
        textFieldConstraints()
        
        nameTextField.placeholder = "Ваше имя..."
        nameTextField.font = .italicSystemFont(ofSize: 20)
        nameTextField.keyboardType = .default
        nameTextField.textColor = .gray
        nameTextField.textAlignment = .left
        nameTextField.borderStyle = .roundedRect
        nameTextField.delegate = self
        nameTextField.returnKeyType = .done
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.enablesReturnKeyAutomatically = true
    }
    
    private func textFieldConstraints() {
        addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            nameTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupMaleButton() {
        maleButtonConstraints()
        
        maleButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        maleButton.setTitle("Не определен...", for: .normal)
        maleButton.setTitleColor(.systemGray4, for: .normal)
        maleButton.contentHorizontalAlignment = .left
        maleButton.titleLabel?.font = .italicSystemFont(ofSize: 20)
        maleButton.layer.cornerRadius = 5
        maleButton.layer.borderWidth = 1
        maleButton.layer.borderColor = UIColor.systemGray5.cgColor
        maleButton.addTarget(viewToController, action: #selector(chooseMaleButtonAction(sender:)), for: .touchUpInside)
    }
    
    private func maleButtonConstraints() {
        addSubview(maleButton)
        maleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            maleButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            maleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            maleButton.topAnchor.constraint(equalTo: maleLabel.bottomAnchor, constant: 16),
            maleButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

// MARK: - Button Actions
extension NameMaleQuestionView {
    
    @objc func chooseMaleButtonAction(sender: UIButton) {
        showAlert()
    }
}

// MARK: - Private Methods
extension NameMaleQuestionView {
    
    private func checkTitleButton() {
        
        let text = self.maleButton.titleLabel?.text!
        if text! == "Не определен..." {
            viewToController?.progressView.setProgress((self.viewToController?.progressView.progress ?? 0) + 1/6, animated: true)
            viewToController?.progressCounter += 1/6
        }
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "", message: "Выберите ваш пол", preferredStyle: .actionSheet)
        let womanAction = UIAlertAction(title: "Женский", style: .default) { action in
            
            self.checkTitleButton()
            
            self.maleButton.setTitleColor(.systemGray, for: .normal)
            self.maleButton.setTitle("Женский", for: .normal)
            self.viewToController?.user.setupMale(male: .female)
        }
        let manAction = UIAlertAction(title: "Мужской", style: .default) { action in
            
            self.checkTitleButton()
            
            self.maleButton.setTitle("Мужской", for: .normal)
            self.maleButton.setTitleColor(.systemGray, for: .normal)
            self.viewToController?.user.setupMale(male: .male)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(womanAction)
        alertController.addAction(manAction)
        alertController.addAction(cancelAction)
        
         if let viewController = viewToController {
            viewController.present(alertController, animated: true)
         }
    }
    
}


// MARK: - TextField Delegate
extension NameMaleQuestionView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            nameTextField.resignFirstResponder()
        }
        return true
    }
   
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField {
            if let text = textField.text {
                if let name = viewToController!.user.name {
                    print(name)
                }
                if viewToController?.user.name == nil {
                    viewToController?.progressView.setProgress((viewToController?.progressView.progress ?? 0) + 1/6, animated: true)
                    viewToController?.progressCounter += 1/6
                }
                viewToController?.user.setupName(name: String(text))
                viewToController?.awhQuestionView.updateWelcomeLabel(text: "\(text), " + (viewToController?.awhQuestionView.getWelcomeLabelText() ?? "заполни данные"))
                print(viewToController!.user.name!)
            }
        }
    }
}
