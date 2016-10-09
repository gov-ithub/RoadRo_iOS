//
//  FlowImagePickerController.swift
//  QuickWins
//
//  Created by Mihai Dumitrache on 18/10/15.
//  Copyright © 2015 Mihai Dumitrache. All rights reserved.
//

import UIKit
import MobileCoreServices

class ImagePicker : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
  var imagePickerController : UIImagePickerController?
  var completion : ((_ image: UIImage?) -> Void)?
  
  private weak var parentController : UIViewController?
  
  init(withCompletion completion:@escaping ((_ image: UIImage?) -> Void)) {
    self.completion = completion
  }
  
  func showFromController(viewController: UIViewController) {
    self.parentController = viewController
    
    let actionController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      let takePhotoAction = UIAlertAction(title: NSLocalizedString("Fotografiază", comment: ""), style: .default) {[weak self] (_) in
        self?.openImagePicker(withSourceType: .camera)
      }
      actionController.addAction(takePhotoAction)
    }
    
    let cameraRollAction = UIAlertAction(title: NSLocalizedString("Alege o imagine", comment: ""), style: .default) {[weak self] (_) in
      self?.openImagePicker(withSourceType: .photoLibrary)
    }
    actionController.addAction(cameraRollAction)
    
    let cancelAction = UIAlertAction(title: NSLocalizedString("Înapoi", comment: ""), style: .destructive) { (_) in
    }
    actionController.addAction(cancelAction)
    viewController.present(actionController, animated: true, completion: nil)
  }
  
  private func openImagePicker(withSourceType source: UIImagePickerControllerSourceType) {
    let imageController = UIImagePickerController()
    imageController.delegate = self;
    imageController.sourceType = source;
    imageController.modalPresentationStyle = .fullScreen;
    imageController.allowsEditing = true;
    self.imagePickerController = imageController
    parentController?.present(imageController, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    let mediaType = info[UIImagePickerControllerMediaType]
    
    let compareResult = CFStringCompare(mediaType as! NSString, kUTTypeImage, CFStringCompareFlags.compareCaseInsensitive)
    if  compareResult == CFComparisonResult.compareEqualTo {
      var image = info[UIImagePickerControllerEditedImage] as? UIImage
      if image == nil {
        image = info[UIImagePickerControllerOriginalImage] as? UIImage;
      }
      
      if let image = image?.imageByScaling(toSize: CGSize(width: 600, height: 600)) {
        self.completion?(image)
      }
      self.imagePickerController?.dismiss(animated: true, completion: nil)
    }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      self.completion?(nil)
      self.imagePickerController?.dismiss(animated: true, completion: nil)
  }
}
