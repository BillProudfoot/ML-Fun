//
//  ViewController.swift
//  MLFun
//
//  Created by Bill Proudfoot on 21/02/2018.
//  Copyright © 2018 Bill Proudfoot. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var confidenceLabel: UILabel!
    
    var imagePicker = UIImagePickerController()
    let resnetModel = Resnet50()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if let image = imageView.image {
            processImage(image: image)
        }
    }
    
    func processImage(image: UIImage) {
        
        if let model = try? VNCoreMLModel(for: self.resnetModel.model) {
            let request = VNCoreMLRequest(model: model, completionHandler: { (request, error) in
                if let results = request.results as? [VNClassificationObservation] {
                    for classification in results {
                        print("ID: \(classification.identifier) Confidence: \(classification.confidence)")
                    }
                    
                    self.descriptionLabel.text = results.first?.identifier
                    
                    if let confidence = results.first?.confidence {
                    
                    self.confidenceLabel.text = "\(confidence * 100.0) %"
                    }
                }
                
            })
            
                if let imageData = UIImagePNGRepresentation(image) {
                    let handler = VNImageRequestHandler(data: imageData, options: [ : ])
                    try? handler.perform([request])
            }
        }
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func photoTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = selectedImage
                processImage(image: selectedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}

