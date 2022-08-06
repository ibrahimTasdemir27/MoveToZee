//
//  Animation+Ext.swift
//  MoveToZee
//
//  Created by haliliboswift on 7.08.2022.
//

import Foundation
import UIKit


extension UIView {
    
    func bounce() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = NSNumber(value: 0.7)
        animation.duration = 0.1
        animation.repeatCount = 0
        animation.autoreverses = true
        self.layer.add(animation, forKey: nil)
    }
    
}
