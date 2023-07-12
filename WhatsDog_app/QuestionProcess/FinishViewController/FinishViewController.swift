//
//  FinishViewController.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 05.07.2023.
//

import UIKit

class FinishViewController: UIViewController {
    
    weak var stepFrom           : DataFillingViewController?
     
    private var progressView    = UIProgressView(progressViewStyle: .bar)
    private var welcomeLabel    = CustomLabel()
    private var finishButton    = UIButton()
    private var centerView      = CustomUIView()
    private var backgroundImage = UIImageView()
    private var dogImage        = UIImageView()
    
    private var resultImage     = UIImage(named: "finishDog")!
    private var resultBreed     = ""
    
    private var timer           : Timer?
    private let progressCount   = Progress(totalUnitCount: 300)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepFrom?.finishViewController = self
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation()
        
    }
    
    deinit {
        print("FinishViewController is dead")
    }
}

// MARK: - Setup Views
extension FinishViewController {
    
    private func setupViews() {
        setupBackgroundImage()
        setupCenterView()
        setupFinishButton()
        setupWelcomeLabel()
        setupProgressView()
        setupDogImage()
    }
    
    private func setupBackgroundImage() {
        backgroundImageConstraints()
        
        backgroundImage.image = UIImage(named: "mainBackgroundImage")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
    }
    
    private func backgroundImageConstraints() {
        view.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupCenterView() {
        centerViewConstraints()
        
        centerView.backgroundColor = .systemBackground
        centerView.layer.cornerRadius = 20
    }
    
    private func centerViewConstraints() {
        view.addSubview(centerView)
        centerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            centerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            centerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            centerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
        ])
    }
    
    private func setupFinishButton() {
        finishButtonConstraints()
        
        finishButton.setTitle("Finish", for: .normal)
        finishButton.setTitleColor(.white, for: .normal)
        finishButton.titleLabel?.font = .boldSystemFont(ofSize: 25)
        finishButton.backgroundColor = .systemGreen
        finishButton.layer.cornerRadius = 10
        finishButton.addTarget(self, action: #selector(backButtonAction(sender:)), for: .touchUpInside)
    }
    
    private func finishButtonConstraints() {
        view.addSubview(finishButton)
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            finishButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finishButton.heightAnchor.constraint(equalToConstant: 50),
            finishButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupWelcomeLabel() {
        welcomeLabelConstraints()
        
        welcomeLabel.text = "ТЫ ЯВНО ПЕС, НО КАКОЙ?"
        welcomeLabel.font = .boldSystemFont(ofSize: 30)
        welcomeLabel.backgroundColor = centerView.backgroundColor
        welcomeLabel.numberOfLines = 0
    }
    
    private func welcomeLabelConstraints() {
        centerView.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeLabel.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: 16),
            welcomeLabel.trailingAnchor.constraint(equalTo: centerView.trailingAnchor, constant: -16),
            welcomeLabel.topAnchor.constraint(equalTo: centerView.topAnchor, constant: 16),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupProgressView() {
        progressViewConstraints()
        
        progressView.trackTintColor = .white
        progressView.progressTintColor = .systemRed
        progressView.observedProgress = progressCount
        
        progressCount.cancellationHandler = {
            DispatchQueue.main.async {
                self.updateWithAnimation {
                    self.welcomeLabel.alpha = 0
                } completion: {
                    self.welcomeLabel.alpha = 1
                    let result = self.stepFrom?.user.match()
                    if let dog = result {
                        self.dogImage.image = dog.image
                        self.welcomeLabel.text = "ТЫ \(dog.name.uppercased())!"
                        self.resultBreed = dog.name
                        self.resultImage = dog.image
                        self.finishButton.isEnabled = true
                        self.finishButton.backgroundColor = .systemGreen
                    }
                }
            }
        }
    }
    
    private func progressViewConstraints() {
        centerView.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint   (equalTo: centerView.leadingAnchor),
            progressView.trailingAnchor.constraint  (equalTo: centerView.trailingAnchor),
            progressView.topAnchor.constraint       (equalTo: centerView.topAnchor, constant: 120),
            progressView.bottomAnchor.constraint    (equalTo: centerView.bottomAnchor, constant: -120)
        ])
    }
    
    private func setupDogImage() {
        dogImageConstraints()
        
        dogImage.image = UIImage(named: "ProgressDog")
        dogImage.contentMode = .scaleAspectFit
    }
    
    private func dogImageConstraints() {
        centerView.addSubview(dogImage)
        dogImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dogImage.leadingAnchor.constraint   (equalTo: centerView.leadingAnchor),
            dogImage.trailingAnchor.constraint  (equalTo: centerView.trailingAnchor),
            dogImage.topAnchor.constraint       (equalTo: centerView.topAnchor, constant: 100),
            dogImage.bottomAnchor.constraint    (equalTo: centerView.bottomAnchor, constant: -100)
        ])
    }
    
}

// MARK: - Actions
extension FinishViewController {
    
    @objc
    private func backButtonAction(sender: UIButton) {
        guard let user = stepFrom?.user else { navigationController?.popToRootViewController(animated: true); return}
        let gender: Gender
        
        switch user.male {
        case .male: gender = .male
        case .female: gender = .female
        default: gender = .female
        }
        
        let friend = Friend(name: user.name!, gender: gender, avatar: user.avatar, resultBreed: resultBreed, resultImage: resultImage)
        Friends.insert(friend, at: 0)
        navigationController?.popToRootViewController(animated: true)
    }
    
}

// MARK: - Private Methods
extension FinishViewController {
    
    private func updateWithAnimation(task: @escaping () -> Void, completion: @escaping() -> Void) {
        UIView.animate(withDuration: 0.25, animations: task) { _ in
            UIView.animate(withDuration: 0.25, animations: completion)
        }
    }
    
    private func startAnimation() {
        DispatchQueue.main.async {
            self.updateWithAnimation {
                self.welcomeLabel.alpha = 0
                // self.progressView.alpha = 0
                self.finishButton.isEnabled = false
                self.finishButton.backgroundColor = .gray
            } completion: {
                self.welcomeLabel.alpha = 1
                self.welcomeLabel.text = "РРРРРРРРРРРРРРР"
            }
        }

        var count: Int64 = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { timer in
            if self.progressCount.fractionCompleted == 1 {
                self.progressCount.cancel()
                timer.invalidate()
            }
            self.progressCount.completedUnitCount = count
            count += 1
        })
    }
    
}

