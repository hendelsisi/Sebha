//
//  InteractiveView.swift
//  Sebha
//
//  Created by hend elsisi on 7/27/18.
//  Copyright © 2018 hend elsisi. All rights reserved.
//

import Foundation
import UIKit
//import AADraggableView

class InteractiveView: KDCircularProgress {
  // var progress:KDCircularProgress?
   // var dragView:AADraggableView?
      
    var padding: CGFloat = 0.0
    var delegate: AADraggableViewDelegate?
    var duration: TimeInterval = 0.1
    var respectedView: UIView?
    var reposition: Reposition = .sticky
    var isEnabled: Bool = true {
        didSet {
            setupTapGesture()
            setNeedsLayout()
        }
    }
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
    var arabicOutput: UILabel = UILabel(frame: CGRect.init())
    
    
    var panGesture: UIPanGestureRecognizer  {
        return UIPanGestureRecognizer(target: self,
                                      action: #selector(self.touchHandler(_:)))
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        trackThickness = 0.07
        progressThickness = 0.07
        progressInsideFillColor = UIColor.darkGray
        trackColor = UIColor.lightGray
        padding = -20.0
        reposition = .sticky
        progressColors = [UIColor.black]
        glowMode = .noGlow
         setupTapGesture()
        
        let viewWidth = self.frame.size.width
        let viewHeight = self.frame.size.height
//        print("width \(viewWidth)")
//        print("height \(viewHeight)")
        let labelWidth:CGFloat = 140.0
        let labelHeight:CGFloat = 80.0
        let xpos = (viewWidth / 2.0) - (labelWidth / 2.0)
        let ypos = (viewHeight / 2.0) - (labelHeight / 2.0)
        arabicOutput.frame = CGRect(x: xpos, y: ypos, width: labelWidth, height: labelHeight)
//        print("x : \(self.center.x)")
//        print("y : \(self.center.y)")
//   arabicOutput.frame = CGRect.init(x: self.center.x, y: self.center.y, width: 140, height: 80)
        arabicOutput.textAlignment = .center
        arabicOutput.font = UIFont.systemFont(ofSize: 70.0, weight: .regular)
       // arabicOutput.text =  String(Int(currentCount)).replacedEnglishDigitsWithArabic
        arabicOutput.textColor = UIColor.white
       //  arabicOutput.center = self.center
        
       addSubview(arabicOutput)
        
    //   progress = KDCircularProgress.init(frame: frame, colors: UIColor.black,UIColor.black,UIColor.black)
////        progress?.IBColor1 =
////        progress?.IBColor2 =
////        progress?.IBColor3 =
//      //  set thickness
//      //  dragView = AADraggableView.init(frame: frame)
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//     override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        print("draw here")
//        setupTapGesture()
//    }

    /// Add or remove pan gesture as required
    func setupTapGesture() {
        guard isEnabled else {
            removeGestureRecognizer(panGesture)
            return
        }
        addGestureRecognizer(panGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector((InteractiveView.handleTap(tapGesture:))))
        let LPressGesture = UILongPressGestureRecognizer(target: self, action: #selector((InteractiveView.handleLongPress(LPressGesture:))))
        
            addGestureRecognizer(LPressGesture)
            addGestureRecognizer(tapGesture)
    }
    
    //Mark: - Handle Gesture
    @objc func handleTap(tapGesture: UITapGestureRecognizer) {
        //  print("click")
        // print(" now : \(currentCount)")
        if (currentIndexCount == maxIndexCount) {
            currentCount += 1

            resizeCounterLabel()
            self.animate(fromAngle: self.angle, toAngle: 0, duration: 0.5, completion: nil)
            currentIndexCount = 0
            print("sdfdsf \(arabicOutput.font.pointSize)")
        }
        else{
            currentCount += 1
            currentIndexCount += 1
            let newAngleValue = newAngle()
            self.animate(toAngle: newAngleValue, duration: 0.5, completion: nil)
        }
    }
    
    func newAngle() -> Double {
        return 360 * (currentIndexCount / maxIndexCount)
    }
    
    func resizeCounterLabel(){
        if currentCount.digitCount > currentDigitCount{
            currentDigitCount = currentCount.digitCount
            if arabicOutput.font.pointSize != 35{
                arabicOutput.font = UIFont.systemFont(ofSize: arabicOutput.font.pointSize - 5, weight:.regular)
            }
        }
    }

    @objc func handleLongPress(LPressGesture: UILongPressGestureRecognizer) {
        currentCount = 0
        currentIndexCount = 0
        currentDigitCount = 2
        self.animate(fromAngle: self.angle, toAngle: 0, duration: 0.5, completion: nil)
    }
    
    @objc func touchHandler(_ sender: UIPanGestureRecognizer) {
        
        sender.translateView(self)
        
        let state = sender.state
        
        guard state == .ended else {
            if state == .began {
                delegate?.draggingDidBegan?(self)
            }
            return
        }
        
        repositionIfNeeded()
        delegate?.draggingDidEnd?(self)
        
    }
    
    open func repositionIfNeeded() {
        
        var newCenter = self.center
        
        switch reposition {
        case .sticky:
            if let minX = repositionMinX {
                newCenter.x = minX
            }
            if let maxX = repositionMaxX {
                newCenter.x = maxX
            }
            if let minY = repositionMinY {
                newCenter.y = minY
            }
            if let maxY = repositionMaxY {
                newCenter.y = maxY
            }
            break
        case .edgesOnly:
            newCenter.x = repositionNearX
            newCenter.y = repositionNearY
            break
        case .topOnly:
            newCenter.y = minY
            break
        case .bottomOnly:
            newCenter.y = maxY
            break
        case .leftOnly:
            newCenter.x = minX
            break
        case .rightOnly:
            newCenter.x = maxX
            break
        default:
            break
        }
        animateToReposition(newCenter)
    }
    
    func animateToReposition(_ toPoint: CGPoint) {
        
        guard toPoint != self.center else {
            return
        }
        UIView.animate(withDuration: duration) {
            self.center = toPoint
        }
    }
}

@objc public protocol AADraggableViewDelegate {
    @objc optional func draggingDidBegan(_ sender: UIView)
    @objc optional func draggingDidEnd(_ sender: UIView)
}

public enum Reposition {
    case sticky
    case free
    case edgesOnly
    case topOnly
    case bottomOnly
    case leftOnly
    case rightOnly
}

extension InteractiveView{
    /// Respected bounds from UIView, default is UIScreen view
    var respectedBounds: CGRect {
        if let bounds = respectedView?.bounds {
            return bounds
        }
        return UIScreen.main.bounds
    }
    
    /// screen min x axis
    var screenMinX: CGFloat {
        return respectedBounds.minX + padding
    }
    
    /// screen mid x axis
    var screenMidX: CGFloat {
        return respectedBounds.midX + padding
    }
    
    /// screen max x axis
    var screenMaxX: CGFloat {
        return respectedBounds.maxX - padding
    }
    
    /// screen min y axis
    var screenMinY: CGFloat {
        return respectedBounds.minY + padding
    }
    
    /// screen mid y axis
    var screenMidY: CGFloat {
        return respectedBounds.midY + padding
    }
    
    /// screen max y axis
    var screenMaxY: CGFloat {
        return respectedBounds.maxY - padding
    }
    
    /// minX
    var minX: CGFloat {
        return screenMinX + bounds.midX
    }
    
    /// maxX
    var maxX: CGFloat {
        return screenMaxX - bounds.midX
    }
    
    /// minY
    var minY: CGFloat {
        return screenMinY + bounds.midY
    }
    
    /// maxY
    var maxY: CGFloat {
        return screenMaxY - bounds.midY
    }
    
    /// Reposition for near x corner
    var repositionNearX: CGFloat {
        if self.frame.midX > screenMidX {
            return maxX
        }
        return minX
    }
    
    /// Reposition for near y corner
    var repositionNearY: CGFloat {
        if self.frame.midY > screenMidY {
            return maxY
        }
        return minY
    }
    
    /// Reposition for minimum x axis
    var repositionMinX: CGFloat? {
        if self.frame.minX < screenMinX {
            return minX
        }
        return nil
    }
    
    /// Reposition for maximum x axis
    var repositionMaxX: CGFloat? {
        if self.frame.maxX > screenMaxX {
            return maxX
        }
        return nil
    }
    
    /// Reposition for minimum y axis
    var repositionMinY: CGFloat? {
        if self.frame.minY < screenMinY {
            return minY
        }
        return nil
    }
    /// Reposition for maximum y axis
    var repositionMaxY: CGFloat? {
        if self.frame.maxY > screenMaxY  {
            return maxY
        }
        return nil
    }
}

// MARK: - UIPanGestureRecognizer extension
extension UIPanGestureRecognizer {    
    /// Translate view center according to translation
    ///
    /// - Parameter view: view to translate
    func translateView(_ view: UIView) {
        let translation = self.translation(in: view)
        let xAxis = view.center.x + translation.x
        let yAxis = view.center.y + translation.y
        view.center = CGPoint(x: xAxis, y: yAxis)
        setTranslation(CGPoint.zero, in: view)
    }
    
}

