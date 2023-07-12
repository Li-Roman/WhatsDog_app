//
//  CropViewController.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 11.07.2023.
//

import UIKit
import CropViewController

class Cropping: NSObject {
    
    var cropper: CropViewController?
    weak var imageToView: PhotoQuestionView?
    
    func showCropper(for image: UIImage, with croppingStyle: CropViewCroppingStyle, in viewController: UIViewController) {
        cropper = CropViewController(croppingStyle: croppingStyle, image: image)
        cropper?.doneButtonColor = .systemRed
        cropper?.cancelButtonColor = .systemRed
        cropper?.doneButtonTitle = "SAVE"
        cropper?.cancelButtonTitle = "QUIT"
        cropper?.delegate = self
        viewController.present(cropper!, animated: true)
    }
}

extension Cropping: CropViewControllerDelegate {
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        cropper?.dismiss(animated: true)
    }
    
    func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        cropper?.dismiss(animated: true)
        print("did circular crop")
        
        imageToView?.setupAvatarImage(image: image)
        imageToView?.viewToController?.user.setupAvatar(image)
    }
}
