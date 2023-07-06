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
    
    var nameQuestionView            = NameMaleQuestionView()
    var awhQuestionView             = AHWQuestionView()
    var hairColorQuestionView       = HairColorQuestionView()
    
    var questionsViewsArr: [QuestionView] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishViewController.stepFrom = self
        nameQuestionView.viewToController = self
        awhQuestionView.viewToController = self
        hairColorQuestionView.viewToController = self
        
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
        backButton.setTitle("BACK", for: .normal)
        nextButton.setTitle("NEXT", for: .normal)
        buttonsStackView.alignment = .center
        buttonsStackView.distribution = .fillEqually
        backButton.addTarget(self, action: #selector(backButtonAction(sender:)), for: .touchUpInside)
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
        
        questionsViewsArr = [nameQuestionView, awhQuestionView, hairColorQuestionView]
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

        navigationItem.backAction = UIAction(handler: { _ in
            
            let alertController = UIAlertController(title: "Wait!", message: "You can lose you data", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "ok", style: .default) { action in
                self.navigationController?.popViewController(animated: true)
            }
            let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true)
            
        })
        
    }
}

// MARK: - ButtonActions
extension DataFillingViewController {
    
    @objc
    private func backButtonAction(sender: CustomButton) {
        var index = 0
        for view in 0..<questionsViewsArr.count {
            if questionsViewsArr[view].isHidden == false {
                index = view
            }
        }
        
        switch index {
        case 0: print("break"); break
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
            var index = 0
            for view in 0..<questionsViewsArr.count {
                if questionsViewsArr[view].isHidden == false {
                    index = view
                }
            }
            
            switch index {
            case questionsViewsArr.count - 1: print("break"); break
            default:
                questionsViewsArr[index].isHidden = true
                questionsViewsArr[index + 1].isHidden = false
            }
        }
    }
}


extension DataFillingViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
