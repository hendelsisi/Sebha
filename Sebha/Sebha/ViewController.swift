//
//  ViewController.swift
//  Sebha
//
//  Created by hend elsisi on 7/22/18.
//  Copyright © 2018 hend elsisi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentCount = 0
    var currentDigitCount = 2
        var currentIndexCount = 0.0
    {
        didSet{
            self.arabicOutput.isHidden = currentCount == 0
             self.arabicOutput.text = String(Int(currentCount)).replacedEnglishDigitsWithArabic
        }
    }
    let maxIndexCount = 99.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        circularProgressView.angle = 0
        
     //  print("fsdfs \(arabicOutput.font.pointSize)")
      //  self.arabicOutput.text = String(Int(currentCount)).replacedEnglishDigitsWithArabic
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector((ViewController.handleTap(gestureRecognizer:))))
        self.circularProgressView.addGestureRecognizer(gestureRecognizer)
        arabicOutput.adjustsFontSizeToFitWidth = true
    //    print("\(currentCount.digitCount)")
      
    }

    @IBOutlet weak var arabicOutput: UILabel!
    
    @IBOutlet weak var circularProgressView: KDCircularProgress!
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
      //  print("click")
    
         print(" now : \(currentCount)")
        if (currentIndexCount == maxIndexCount) {
             currentCount += 1
            
            resizeCounterLabel()
            circularProgressView.animate(fromAngle: circularProgressView.angle, toAngle: 0, duration: 0.5, completion: nil)
            currentIndexCount = 0
            print("sdfdsf \(arabicOutput.font.pointSize)")
        }
        else{
            currentCount += 1
            currentIndexCount += 1
            let newAngleValue = newAngle()
            circularProgressView.animate(toAngle: newAngleValue, duration: 0.5, completion: nil)
        }
    }
    
    func resizeCounterLabel(){
        if currentCount.digitCount > currentDigitCount{
            currentDigitCount = currentCount.digitCount
            if arabicOutput.font.pointSize != 35{
                arabicOutput.font = UIFont.systemFont(ofSize: arabicOutput.font.pointSize - 5, weight:.regular)
                arabicOutput.sizeToFit()
            }
        }
    }

    func newAngle() -> Double {
        return 360 * (currentIndexCount / maxIndexCount)
    }
    
    @IBAction func gfgf(_ sender: Any) {
        currentCount = 0
        currentIndexCount = 0
        currentDigitCount = 2
        circularProgressView.animate(fromAngle: circularProgressView.angle, toAngle: 0, duration: 0.5, completion: nil)
    }
    

}

