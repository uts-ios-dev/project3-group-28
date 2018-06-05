//
//  ObjectButton.swift
//  ToddyTime
//
//  Created by Shankhar on 5/26/18.
//  Copyright © 2018 Shankhar. All rights reserved.
//

import UIKit

class ObjectButton: UIButton {
    
    var originPoint: CGPoint = CGPoint.zero
    var object = ""
    
    private var completion: CompletionClosure
    
    
    init(withOrigin origin: CGPoint, object: String) {
        super.init(frame: CGRect.frame(with: origin))
        self.originPoint = origin
        self.object = object
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    //setup button ui
    private func setupButton() {
        self.setBackgroundImage(UIImage(named: object), for: .normal)
        self.contentMode = .scaleAspectFit
    }
    
    
    //show animation
    func showBubble(completion: CompletionClosure) {
        self.isUserInteractionEnabled = false
        scale(fromValue: 0.1, toValue: 1, withDuration: 0.5)
        self.completion = completion
    }
    
    
    //hide animation
    func hideBubble(completion: CompletionClosure) {
        self.isUserInteractionEnabled = false
        scale(fromValue: 1, toValue: 0.1, withDuration: 0.5)
        self.completion = completion
    }
    
    
    //pop animation
    func popBubble(completion: CompletionClosure) {
        self.isUserInteractionEnabled = false
        scale(fromValue: 1, toValue: 2, withDuration: 0.5)
        fade(fromValue: 1, toValue: 0, withDuration: 0.5)
        self.completion = completion
    }
    
    
    //method called after the animation is completed
    override func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.isUserInteractionEnabled = true
        if let completion = completion {
            completion()
            self.completion = nil
        }
    }
}
