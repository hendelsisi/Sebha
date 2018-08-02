//
//  ViewController.swift
//  Sebha
//
//  Created by hend elsisi on 7/22/18.
//  Copyright © 2018 hend elsisi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,AADraggableViewDelegate {

    @IBOutlet weak var testtt: UIView!
    fileprivate  var currentCount = 0
   fileprivate var currentDigitCount = 2
   fileprivate  var currentIndexCount = 0.0
    {
        didSet{
            self.arabicOutput.isHidden = currentCount == 0
             self.arabicOutput.text = String(Int(currentCount)).replacedEnglishDigitsWithArabic
        }
    }
   fileprivate let maxIndexCount = 99.0

    @IBOutlet weak var arabicOutput: UILabel!
   
    @IBOutlet weak var circularProgressView: KDCircularProgress!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var progress = InteractiveView.init(frame: CGRect.init(x: self.view.center.x,y: self.view.center.y, width: 150, height: 150))
        if Device.IS_5_5_INCHES() || Device.IS_4_7_INCHES() || Device.IS_5_8_INCHES(){
            progress = InteractiveView.init(frame: CGRect.init(x: self.view.center.x,y: self.view.center.y, width: 200, height: 200))
        }
        
        progress.center = self.view.center
       
        progress.respectedView = self.view
        progress.delegate = self
        self.view.addSubview(progress)
    }
    
//    func resizeCounterLabel(){
//        if currentCount.digitCount > currentDigitCount{
//            currentDigitCount = currentCount.digitCount
//            if arabicOutput.font.pointSize != 35{
//                arabicOutput.font = UIFont.systemFont(ofSize: arabicOutput.font.pointSize - 5, weight:.regular)
//            }
//        }
//    }
//
//    func newAngle() -> Double {
//        return 360 * (currentIndexCount / maxIndexCount)
//    }
    
    @IBAction func gfgf(_ sender: Any) {
        currentCount = 0
        currentIndexCount = 0
        currentDigitCount = 2
        circularProgressView.animate(fromAngle: circularProgressView.angle, toAngle: 0, duration: 0.5, completion: nil)
    }
    
    // Add delegate methods and observe changes!
    func draggingDidBegan(_ sender: UIView) {
        // Dragging did began of sender
    }
    
    func draggingDidEnd(_ sender: UIView) {
        // Dragging did end of sender
    }
    
}

//extension ViewController{
//    
//    //Mark: - Handle Gesture
//    @objc func handleTap(tapGesture: UITapGestureRecognizer) {
//        //  print("click")
//        // print(" now : \(currentCount)")
//        if (currentIndexCount == maxIndexCount) {
//            currentCount += 1
//            
//            resizeCounterLabel()
//            circularProgressView.animate(fromAngle: circularProgressView.angle, toAngle: 0, duration: 0.5, completion: nil)
//            currentIndexCount = 0
//            print("sdfdsf \(arabicOutput.font.pointSize)")
//        }
//        else{
//            currentCount += 1
//            currentIndexCount += 1
//            let newAngleValue = newAngle()
//            circularProgressView.animate(toAngle: newAngleValue, duration: 0.5, completion: nil)
//        }
//    }
//    
//    @objc func handleLongPress(LPressGesture: UILongPressGestureRecognizer) {
//        currentCount = 0
//        currentIndexCount = 0
//        currentDigitCount = 2
//        circularProgressView.animate(fromAngle: circularProgressView.angle, toAngle: 0, duration: 0.5, completion: nil)
//    }
//    
////    @objc func handlePan(panGesture: UILongPressGestureRecognizer) {
//////        let draggingPoint: CGPoint = panGesture.location(in: view)
//////        circularProgressView.center = draggingPoint
////    }
//    
//    //Mark: - Handle Touches
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//       // if let touch = event?.allTouches?.first {
////            let touchLocation = touch.location(in: view)
//          //  circularProgressView.center = touchLocation
//           // arabicOutput.center = circularProgressView.center
//            
//        //}
//        
////        let fTouch = event?.allTouches?.first
////       let point = fTouch?.location(in: circularProgressView)
//        for touch in touches {
//           //  let touchLocation = touch.location(in: view)
////            self.circularProgressView.transform = translation(from: self.circularProgressView.center, to: touch.preciseLocation(in: self.view))
////            self.arabicOutput.transform = translation(from: self.arabicOutput.center, to: touch.preciseLocation(in: self.view))
//            
//            
////            self.circularProgressView.transform = translation(from: self.circularProgressView.center, to: touch.preciseLocation(in: self.view))
////            self.arabicOutput.transform = translation(from: self.arabicOutput.center, to: touch.preciseLocation(in: self.view))
//            
//        }
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
////        for touch in touches {
////            circularProgressView.transform = translation(from: circularProgressView.center, to: touch.preciseLocation(in: self.view))
////        }
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
////       for touch in touches {
////        circularProgressView.transform = translation(from: circularProgressView.center, to: touch.preciseLocation(in: self.view))}
//    }
//    
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
////      for touch in touches {
////        circularProgressView.transform = translation(from: circularProgressView.center, to: touch.preciseLocation(in: self.view))}
//    }
//    
////    func translation(from p1: CGPoint, to p2: CGPoint) ->CGAffineTransform {
////        return CGAffineTransform(translationX: p2.x - p1.x, y: p2.y - p1.y)
////    }
//    
////    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
////        for touch in touches {
////            self.inputView?.transform = translation(from: (self.inputView?.center)!, to: touch.preciseLocation(in: self))
////        }
////    }
//    
//}

