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

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
   
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var confidenceLabel: UILabel!
    
    let resnetModel = Resnet50()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let model = try? VNCoreMLModel(for: self.resnetModel.model) {
            let request = VNCoreMLRequest(model: model, completionHandler: { (request, error) in
                if let results = request.results as? [VNClassificationObservation] {
                    for classification in results {
                        print("ID: \(classification.identifier) Confidence: \(classification.confidence)")
                    }
                }
                
            })
            if let image = UIImage(named: "golfontee") {
                if let imageData = UIImagePNGRepresentation(image) {
                    let handler = VNImageRequestHandler(data: imageData, options: [ : ])
                    try? handler.perform([request])
                    
                }
            }
        }
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
    }
    
    @IBAction func photoTapped(_ sender: Any) {
    }
    
}

