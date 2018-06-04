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
    
    private func setupButton() {
        self.setBackgroundImage(UIImage(named: object), for: .normal)
        self.contentMode = .scaleAspectFit
    }
    
    func showBubble(completion: CompletionClosure) {
        self.isUserInteractionEnabled = false
        scale(fromValue: 0.1, toValue: 1, withDuration: 0.5)
        self.completion = completion
    }
    
    func hideBubble(completion: CompletionClosure) {
//        if isPopped { return }
        self.isUserInteractionEnabled = false
        scale(fromValue: 1, toValue: 0.1, withDuration: 0.5)
        self.completion = completion
    }
    
    func popBubble(completion: CompletionClosure) {
        self.isUserInteractionEnabled = false
//        isPopped = true
        scale(fromValue: 1, toValue: 2, withDuration: 0.5)
        fade(fromValue: 1, toValue: 0, withDuration: 0.5)
        self.completion = completion
    }
    
    
    override func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.isUserInteractionEnabled = true
        if let completion = completion {
            completion()
            self.completion = nil
        }
    }
}
