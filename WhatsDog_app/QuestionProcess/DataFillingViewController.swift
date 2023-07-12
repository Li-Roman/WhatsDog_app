//
//  DataFillingViewController.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import UIKit

protocol QuestionView: UIView {
    func setupView()
}

class DataFillingViewController: UIViewController {
    
    private var finishValidator     = false
    
    var finishViewController        = FinishViewController()
    var user                        = User()
    private let mainBackgroundImage = UIImageView()
    var progressView                = UIProgressView(progressViewStyle: .default)
    var progressCounter             = 0.0 {
        didSet {
            if progressCounter >= 1.0 {
                finishValidator = true
                nextButton.setTitle("FINISH", for: .normal)
                nextButton.backgroundColor = .systemGreen
            }
        }
    }

    private(set) var questionsView  = CustomUIView()
    private let buttonsStackView    = UIStackView()
    private(set) var backButton     = CustomButton()
    private(set) var nextButton     = CustomButton()
    private var isVisiblePhotoQuestion = true {
        didSet {
            toggleBackButton(isVisiblePhotoQuestion)
        }
    }
    
    var photoQuestionView           = PhotoQuestionView()
    var nameQuestionView            = NameMaleQuestionView()
    var awhQuestionView             = AHWQuestionView()
    var hairColorQuestionView       = HairColorQuestionView()
    
    var questionsViewsArr: [QuestionView] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoQuestionView.viewToController      = self
        finishViewController.stepFrom           = self
        nameQuestionView.viewToController       = self
        awhQuestionView.viewToController        = self
        hairColorQuestionView.viewToController  = self
        
        setupViews()
        
    }

    deinit {
        print("DataFillingViewController dead")
    }
}

// MARK: - Setup Views
extension DataFillingViewController {
    
    private func setupViews() {
        setupMainBackground()
        setupQuestuionView()
        setupButtonStack()
        setupProgressView()
        setupBackBarButton()
    }
    
    private func setupMainBackground() {
        view.addSubview(mainBackgroundImage)
        mainBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainBackgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainBackgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainBackgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            mainBackgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        mainBackgroundImage.image = UIImage(named: "mainBackgroundImage")
        mainBackgroundImage.contentMode = .scaleAspectFill
        mainBackgroundImage.clipsToBounds = true
    }
    
    private func setupQuestuionView() {
        
        view.addSubview(questionsView)
        questionsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            questionsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            questionsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            questionsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
        ])
        questionsView.backgroundColor = .systemBackground
        questionsView.layer.cornerRadius = 20
        questionsView.clipsToBounds = true
        
        addSubViews()
    }
    
    private func setupButtonStack() {
        
        view.addSubview(buttonsStackView)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            buttonsStackView.topAnchor.constraint(equalTo: questionsView.bottomAnchor, constant: 20),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        buttonsStackView.addArrangedSubview(backButton)
        buttonsStackView.addArrangedSubview(nextButton)
        buttonsStackView.spacing = 20
        buttonsStackView.alignment = .center
        buttonsStackView.distribution = .fillEqually
        setupBackButton()
        setupNextButton()
    }
    
    private func setupBackButton() {
        backButton.setTitle("BACK", for: .normal)
        backButton.isEnabled = true
        backButton.backgroundColor = .gray
        backButton.addTarget(self, action: #selector(backButtonAction(sender:)), for: .touchUpInside)
    }
    
    private func setupNextButton() {
        nextButton.setTitle("NEXT", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonAction(sender:)), for: .touchUpInside)
    }
    
    private func setupProgressView() {
        
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            progressView.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        progressView.progressTintColor = .systemRed
        progressView.trackTintColor = .white
    }
    
    private func addSubViews() {
        
        questionsViewsArr = [photoQuestionView ,nameQuestionView, awhQuestionView, hairColorQuestionView]
        for view in questionsViewsArr {
            questionsView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: questionsView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: questionsView.trailingAnchor),
                view.topAnchor.constraint(equalTo: questionsView.topAnchor),
                view.bottomAnchor.constraint(equalTo: questionsView.bottomAnchor)
            ])
            view.isHidden = true
        }
        questionsViewsArr[0].isHidden = false
    }
    
    
    private func setupBackBarButton() {

        let buttonImage = UIImage(systemName: "arrowshape.backward.fill")!
        let button = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: #selector(backBarButtonAction(sender:)))
        navigationItem.leftBarButtonItem = button
    }
}

// MARK: - Private Methods
extension DataFillingViewController {
    
    private func toggleBackButton(_ condition: Bool) {
        switch condition {
        case true:
            backButton.backgroundColor = .gray
            backButton.isEnabled = false
        case false:
            backButton.backgroundColor = .systemRed
            backButton.isEnabled = true
        }
    }
    
    private func whichIsHidden() -> Int {
        var index = 0
        for view in 0..<questionsViewsArr.count {
            if !questionsViewsArr[view].isHidden {
                index = view
            }
        }
        return index
    }
    
}

// MARK: - ButtonActions
extension DataFillingViewController {
    
    @objc
    private func backBarButtonAction(sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Wait!", message: "You can lose you data", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    
    @objc
    private func backButtonAction(sender: CustomButton) {
        let index = whichIsHidden()
        isVisiblePhotoQuestion = index <= 1 ? true : false
        switch index {
        case 0: break
        default:
            questionsViewsArr[index].isHidden = true
            questionsViewsArr[index - 1].isHidden = false
        }
    }
    
    @objc
    private func nextButtonAction(sender: CustomButton) {
        
        if finishValidator {
            let vc = finishViewController
            navigationController?.pushViewController(vc, animated: true)
            
        } else {
            
            let index = whichIsHidden()
            isVisiblePhotoQuestion = false
            switch index {
            case questionsViewsArr.count - 1: break
            default:
                questionsViewsArr[index].isHidden = true
                questionsViewsArr[index + 1].isHidden = false
            }
        }
    }
}
 
// MARK: - UIPopoverPresentationControllerDelegate
extension DataFillingViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}


