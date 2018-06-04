//
//  CGRect+Extension.swift
//  ToddyTime
//
//  Created by Shankhar on 5/26/18.
//  Copyright © 2018 Shankhar. All rights reserved.
//

import UIKit

extension CGRect {
    static func frame(with origin: CGPoint) -> CGRect {
        return CGRect(origin: origin, size: AppDefault.buttonSize)
    }
}
