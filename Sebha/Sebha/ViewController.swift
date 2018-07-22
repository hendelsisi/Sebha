//
//  ViewController.swift
//  Sebha
//
//  Created by hend elsisi on 7/22/18.
//  Copyright © 2018 hend elsisi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
    }
    
    @IBOutlet weak var circularProgressView: KDCircularProgress!
    
    @IBAction func sdfs(_ sender: Any) {
        circularProgressView.animate(toAngle: 90, duration: 0.5, completion: nil)

    }

}

