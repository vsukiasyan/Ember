//
//  ViewController.swift
//  Ember
//
//  Created by Vic Sukiasyan on 5/9/18.
//  Copyright © 2018 Vic Sukiasyan. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    @IBOutlet weak var swipeLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(wasDragged(gesture:)))
        swipeLbl.addGestureRecognizer(gesture)
    }
    
    @objc func wasDragged(gesture: UIPanGestureRecognizer) {
        let labelPoint = gesture.translation(in: view)
        swipeLbl.center = CGPoint(x: view.bounds.width / 2 + labelPoint.x, y: view.bounds.height / 2 + labelPoint.y)
        
        let xFromCenter = view.bounds.width / 2 - swipeLbl.center.x
        
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 200)
        
        let scale = min(100 / abs(xFromCenter), 1)
        
        var scaledAndRotated = rotation.scaledBy(x: scale, y: scale)
        swipeLbl.transform = scaledAndRotated
        
        if gesture.state == .ended {
            if swipeLbl.center.x < (view.bounds.width / 2 - 100) {
                print("Not interested")
            } else if swipeLbl.center.x > (view.bounds.width / 2 - 100) {
                print("Interested")
            }
            
            rotation = CGAffineTransform(rotationAngle: 0)
            scaledAndRotated = rotation.scaledBy(x: 1, y: 1)
            swipeLbl.transform = scaledAndRotated
            
            swipeLbl.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

