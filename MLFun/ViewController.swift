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
    
    let resnetModel = Resnet50()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let model = try? VNCoreMLModel(for: self.resnetModel.model) {
            
        }
   
    }
}

