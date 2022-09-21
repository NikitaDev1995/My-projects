//
//  PhotoCameraAlert.swift
//  Мой день
//
//  Created by Nikita Skripka on 31.08.2022.
//

import UIKit

extension UIViewController {
    
    func alertPhotoOrCamera(completionHandler: @escaping(UIImagePickerController.SourceType) -> Void ) {
        
        let alerController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            let camera = UIImagePickerController.SourceType.camera
            completionHandler(camera)
        }
        
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { _ in
            let photoLibrary = UIImagePickerController.SourceType.photoLibrary
            completionHandler(photoLibrary)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alerController.addAction(camera)
        alerController.addAction(photoLibrary)
        alerController.addAction(cancel)
        
        present(alerController, animated: true)
    }
}
