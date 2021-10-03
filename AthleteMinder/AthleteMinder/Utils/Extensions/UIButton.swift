//
//  UIButton.swift
//  AthleteMinder
//
//  Created by Himan Dhawan on 14/09/21.
//

import Foundation
import UIKit

/// Flip Animation

extension UIButton {
    
    func flip(buttonTag : Int, animationDelegate : CAAnimationDelegate?) {
        let flipAnimation = CASpringAnimation(keyPath: "transform.rotation.x")
        flipAnimation.setValue(buttonTag, forKey: "tag")
        flipAnimation.fromValue = Double.pi
        flipAnimation.toValue = CGFloat(Double.pi*2)
        flipAnimation.isRemovedOnCompletion = false
        flipAnimation.duration = 1
        flipAnimation.repeatCount = 0
        flipAnimation.damping = 8
        flipAnimation.initialVelocity = 2
        flipAnimation.delegate = animationDelegate
        layer.add(flipAnimation, forKey: nil)
    }
    
}


/// Pulse Animation

extension UIButton {
    
    func removePulse() {
        
        self.layer.sublayers?.forEach({ layer in
            
            if let shape = layer.value(forKey: "Shape") as? String, shape == "CircularShape" {
                UIView.animate(withDuration: 0.3) {
                    layer.isHidden = true
                } completion: { _ in
                    layer.removeFromSuperlayer()
                }
            }

            layer.removeAllAnimations()
            
        })
        
    }
    
    func createPulse() {
        
        var isAlreadyPulsating = false
        
        self.layer.sublayers?.forEach({ layer in
            if let shape = layer.value(forKey: "Shape") as? String, shape == "CircularShape" {
                isAlreadyPulsating = true
            }
        })
        
        if isAlreadyPulsating {
            return
        }
        
        var pulseArray = [CAShapeLayer]()
        
            for _ in 0...2 {
                let circularPath = UIBezierPath(arcCenter: .zero, radius: 70, startAngle: 0, endAngle: 2 * .pi , clockwise: true)
                let pulsatingLayer = CAShapeLayer()
                pulsatingLayer.setValue("CircularShape", forKey: "Shape")
                pulsatingLayer.isHidden = true
                pulsatingLayer.path = circularPath.cgPath
                pulsatingLayer.lineWidth = 5
                pulsatingLayer.fillColor = UIColor.clear.cgColor
                pulsatingLayer.lineCap = .round
                pulsatingLayer.position = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.width / 2.0)
                self.layer.addSublayer(pulsatingLayer)
                pulseArray.append(pulsatingLayer)
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self.animatePulsatingLayerAt(pulseArray: pulseArray, index: 0)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                    self.animatePulsatingLayerAt(pulseArray: pulseArray, index: 1)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.animatePulsatingLayerAt(pulseArray: pulseArray, index: 2)
                    })
                })
            })
            
        }
        
        
    func animatePulsatingLayerAt(pulseArray : [CAShapeLayer], index:Int) {
            if pulseArray.count == 0 {
                return
            }
            
            pulseArray[index].strokeColor = UIColor.white.cgColor
            pulseArray[index].isHidden = false
            
            
            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.fromValue = 0.5
        scaleAnimation.toValue = 0.7
            
            
            let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
            opacityAnimation.fromValue = 1
            opacityAnimation.toValue = 0.0
           
            let groupAnimation = CAAnimationGroup()
            groupAnimation.animations = [scaleAnimation, opacityAnimation]
            groupAnimation.duration = 2
            groupAnimation.repeatCount = .infinity
            groupAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            //adding groupanimation to the layer
            pulseArray[index].add(groupAnimation, forKey: "groupanimation")
            
        }
    
}


// Squeeze button

extension UIButton {
    func squeeze(completion : AnimationCompletion?) {
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0.6
            self.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        } completion: { _ in
            completion?(true)
        }
    }
}

// Release the squeezed button

extension UIButton {
    func release(completion : AnimationCompletion?) {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
            self.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        } completion: { _ in
            completion?(true)
        }
    }
}

// Enlarge button

extension UIButton {
    func enlarge(completion : AnimationCompletion?) {
        UIView.animate(withDuration: 0.1) {
            self.alpha = 1
            self.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        } completion: { _ in
            completion?(true)
        }
    }
}
