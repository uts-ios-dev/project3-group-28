//
//  UIView+Extension.swift
//  ToddyTime
//
//  Created by Shankhar on 5/26/18.
//  Copyright © 2018 Shankhar. All rights reserved.
//

import UIKit

extension UIView {
    
    //MARK: - ANIMATION FUNCTIONS
    
    //hide animation for view
    func hideAnimate(_ completed:((_ done:Bool)->())! = nil) {
        if let parent = self.superview {
            UIView.animate(withDuration: 0.3, animations: {
                parent.alpha = 0.0
            })
            
            self.layer.shouldRasterize = true
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: { (finished) in
                
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.alpha = 0
                    self.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
                }, completion: { (done) in
                    //done
                    if let completed = completed {
                        completed(done)
                    }
                })
            })
        }
    }

    
    //scale animation for view
    func scale(fromValue: Double, toValue: Double, withDuration: Double) {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.delegate = self
        scaleAnimation.duration = withDuration
        scaleAnimation.fromValue = fromValue
        scaleAnimation.toValue = toValue
        layer.add(scaleAnimation, forKey: "scale")
        
    }
    
    
    //fade animation for view
    func fade(fromValue: Double, toValue: Double, withDuration: Double) {
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.delegate = self
        fadeAnimation.duration = withDuration
        fadeAnimation.fromValue = fromValue
        fadeAnimation.toValue = toValue
        layer.add(fadeAnimation, forKey: "fade")
    }
}


//MARK: - ANIMATION DELEGATE

extension UIView: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    }
}

