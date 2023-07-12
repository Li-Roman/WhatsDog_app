//
//  TakeAPhotoViewController.swift
//  WhatsDog_app
//
//  Created by Роман Хилюк on 08.07.2023.
//

import UIKit
import CropViewController

class ImagePicker: NSObject {
    
    var imagePickerController = UIImagePickerController()
    private var presenterVC: UIViewController?
    var cropper = Cropping()
    weak var imageToView: PhotoQuestionView?
    
    func showImagePicker(in viewController: UIViewController, with sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        presenterVC = viewController
        
        viewController.present(imagePickerController, animated: true)
    }
    
}


extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        
        picker.dismiss(animated: true)
        
//        showCropVC(image: image)
        cropper.showCropper(for: image, with: .circular, in: presenterVC!)
        cropper.imageToView = imageToView
    }
    
}


extension ImagePicker {
    
    private func showCropVC(image: UIImage) {
        
        let vc = CropViewController(croppingStyle: .circular, image: image)
        
        presenterVC!.present(vc, animated: true)
    }
    
}
