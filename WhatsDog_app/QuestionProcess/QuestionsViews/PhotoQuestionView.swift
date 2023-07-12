//
//  PhotoQuestionView.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 08.07.2023.
//

import UIKit

class PhotoQuestionView: CustomUIView {
    
    weak var viewToController: DataFillingViewController?
    
    private(set) var welcomeLabel    = UILabel()
    private(set) var avatarView      = UIImageView()
    private(set) var addButton       = UIButton()
    private(set) var takeAShotButton = UIButton()
    private(set) var alertController = UIAlertController()
    private let imagePicker          = ImagePicker()
    private let cropper              = Cropping()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    override func setupView() {
        super.setupView()
        
        viewToController?.photoQuestionView = self
        
        backgroundColor = .systemBackground
        
        cropper.imageToView = self
        imagePicker.imageToView = self
        
        setupViews()
    }
    
    deinit {
        print("PhotoQuestionView is dead")
    }
    
}

// MARK: - Public Methods
extension PhotoQuestionView {
    
    public func setupAvatarImage(image: UIImage) {
        avatarView.backgroundColor = .systemBackground
        avatarView.image = image
        avatarView.contentMode = .scaleAspectFit
    }
    
}

// MARK: - Setup Views
extension PhotoQuestionView {
    
    private func setupViews() {
        setupWelcomeLabel()
        setupAvatarView()
        setupAddButton()
        // setupShotButton()
    }
    
    private func setupWelcomeLabel() {
        welcomeLabelConstraints()
        
        welcomeLabel.text = "TAKE A SHOT!"
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont(name: "Helvetica", size: 30)
        welcomeLabel.numberOfLines = 0
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
    
    private func setupAvatarView() {
        avatarViewConstraints()
        defaultAvatarView()
    }
    
    private func defaultAvatarView() {
        avatarView.backgroundColor = .gray
        avatarView.layer.cornerRadius = 266/2
        let image = UIImage(systemName: "camera.fill")
        let config = UIImage.SymbolConfiguration(pointSize: 60)
        avatarView.image = image?.withConfiguration(config)
        avatarView.tintColor = .white
        avatarView.clipsToBounds = true
        avatarView.contentMode = .center
    }
    
    private func avatarViewConstraints() {
        addSubview(avatarView)
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarView.heightAnchor.constraint(equalToConstant: 266),
            avatarView.widthAnchor.constraint(equalToConstant: 260)
        ])
    }
    
    private func setupAddButton() {
        addButtonConstraints()

        addButton.addTarget(viewToController, action: #selector(addButtonAction(sender:)), for: .touchUpInside)
}
    
    private func addButtonConstraints() {
        addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 266),
            addButton.widthAnchor.constraint(equalToConstant: 260)
        ])
    }
    
//    private func setupShotButton() {
//        shotButtonConstraints()
//
//        let config = UIImage.SymbolConfiguration(pointSize: 20)
//        let image = UIImage(systemName: "camera")?.withConfiguration(config)
//
//        takeAShotButton.configuration = .filled()
//        takeAShotButton.configuration?.image = image?.withTintColor(.white)
//        takeAShotButton.configuration?.imagePlacement = .leading
//        takeAShotButton.configuration?.titlePadding = 10
//        takeAShotButton.configuration?.imagePadding = 10
//        var container = AttributeContainer()
//        container.font = .boldSystemFont(ofSize: 20)
//        takeAShotButton.configuration?.attributedTitle = AttributedString("TAKE A SHOT", attributes: container)
//        takeAShotButton.configuration?.baseBackgroundColor = .systemRed
//        takeAShotButton.configuration?.baseForegroundColor = .systemBackground
//        takeAShotButton.configuration?.cornerStyle = .large
//
//    }
//
//    private func shotButtonConstraints() {
//        addSubview(takeAShotButton)
//        takeAShotButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            takeAShotButton.centerXAnchor.constraint(equalTo: centerXAnchor),
//            takeAShotButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
//            takeAShotButton.heightAnchor.constraint(equalToConstant: 60),
//            takeAShotButton.widthAnchor.constraint(equalToConstant: 200)
//        ])
//    }
}


// MARK: - Private Methods
extension PhotoQuestionView {
    
    private func setupAlertController() {
        alertController = UIAlertController(title: "\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        
        let avatarsView = UIView()
        alertController.view.addSubview(avatarsView)
        avatarsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarsView.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 10),
            avatarsView.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 10),
            avatarsView.trailingAnchor.constraint(equalTo: alertController.view.trailingAnchor, constant: -10),
            avatarsView.heightAnchor.constraint(equalToConstant: 80)
        ])
        setupAvatarsView(avatarsView)
        

        let takePhotoaction = UIAlertAction(title: "Сделать снимок", style: .default) { action in
            print("camera action selected")
            self.imagePicker.showImagePicker(in: self.viewToController!, with: .camera)
        }
        let galeryAction = UIAlertAction(title: "Открыть галерею", style: .default) { action in
            print("library action selected")
            self.imagePicker.showImagePicker(in: self.viewToController!, with: .photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { action in
            print("cancel action")
        }
        let destructiveAction = UIAlertAction(title: "Удалить фото", style: .destructive ) { action in
            self.defaultAvatarView()
        }
        
        [takePhotoaction, galeryAction, cancelAction, destructiveAction].forEach {
            alertController.addAction($0)
        }
        
        viewToController?.present(alertController, animated: true)
    }
    
    private func setupAvatarsView(_ view: UIView) {
        
        let avatars: [UIImage] = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!, UIImage(named: "10")!, UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!, UIImage(named: "10")!, UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named: "8")!, UIImage(named: "9")!, UIImage(named: "10")!]
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        scrollView.contentSize = CGSize(width: CGFloat(90 * (avatars.count - 1)), height: view.frame.height)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        let stackView           = UIStackView()
        stackView.axis          = .horizontal
        stackView.spacing       = 10
        stackView.alignment     = .center
        stackView.distribution  = .fill
        
        
        for avatar in 0..<avatars.count - 1 {
            let avatarButton = makeAvatarButton(with: avatars[avatar])
            scrollView.addSubview(avatarButton)
            avatarButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                avatarButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: CGFloat(90 * avatar)),
                avatarButton.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
                avatarButton.heightAnchor.constraint(equalToConstant: 80),
                avatarButton.widthAnchor.constraint(equalToConstant: 80)
            ])
        }
        
    }
    
    private func makeAvatarButton(with image: UIImage) -> UIButton {
        let avatarButton = UIButton()
        
        avatarButton.backgroundColor = .red
        avatarButton.setImage(image, for: .normal)
        avatarButton.layer.cornerRadius = 5
        avatarButton.imageView?.contentMode = .scaleAspectFill
        avatarButton.clipsToBounds = true
        
        avatarButton.addTarget(self, action: #selector(avatarButtonAction(sender:)), for: .touchUpInside)
        
        return avatarButton
    }
    
}


// MARK: - Actions
extension PhotoQuestionView {
    
    @objc
    private func avatarButtonAction(sender: UIButton) {
        alertController.dismiss(animated: true)
        cropper.showCropper(for: (sender.imageView?.image)!, with: .circular, in: viewToController!)
    }
    
    @objc
    private func addButtonAction(sender: UIButton) {
        setupAlertController()
    }

}



