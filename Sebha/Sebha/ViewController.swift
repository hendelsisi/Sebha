//
//  ViewController.swift
//  Sebha
//
//  Created by hend elsisi on 7/22/18.
//  Copyright © 2018 hend elsisi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentCount = 0.0
    {
        didSet{
                self.arabicOutput.isHidden = currentCount == 0.0
             self.arabicOutput.text = String(Int(currentCount)).replacedEnglishDigitsWithArabic
        }
    }
    let maxCount = 19.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        circularProgressView.angle = 0
//        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector((ViewController.handleTap(gestureRecognizer:))))
//        self.circularProgressView.addGestureRecognizer(gestureRecognizer)
    }

    @IBOutlet weak var arabicOutput: UILabel!
    
    
    @IBAction func dsfasd(_ sender: Any) {
        if currentCount != maxCount {
            currentCount += 1
            let newAngleValue = newAngle()
            circularProgressView.animate(toAngle: newAngleValue, duration: 0.5, completion: nil)
        }
        else{
            currentCount += 1
            //currentCount = 0
            circularProgressView.animate(fromAngle: circularProgressView.angle, toAngle: 0, duration: 0.5, completion: nil)
        }
    }
    
    @IBOutlet weak var circularProgressView: KDCircularProgress!
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
        print("inside circle")
        if currentCount != maxCount {
            currentCount += 1
            let newAngleValue = newAngle()
            circularProgressView.animate(toAngle: newAngleValue, duration: 0.5, completion: nil)
        }
        else{
            currentCount = 0
            circularProgressView.animate(fromAngle: circularProgressView.angle, toAngle: 0, duration: 0.5, completion: nil)
        }
    }

    func newAngle() -> Double {
        return 360 * (currentCount / maxCount)
    }
    
    @IBAction func gfgf(_ sender: Any) {
        currentCount = 0
        circularProgressView.animate(fromAngle: circularProgressView.angle, toAngle: 0, duration: 0.5, completion: nil)
    }
    

}

