//
//  UIImageView.swift
//  AthleteMinder
//
//  Created by Himan Dhawan on 14/09/21.
//

import Foundation
import UIKit

public typealias AnimationCompletion = (_ success: Bool) -> Void

extension UIImageView {
    func animate(completion : @escaping AnimationCompletion) {
        self.alpha = 0.0
        self.transform = CGAffineTransform.init(scaleX: 10, y: 10)
        UIView.animate(withDuration: 1) {
            self.alpha = 1.0
            self.transform = CGAffineTransform.init(scaleX: 0.3, y: 0.3)

        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                
            } completion: { _ in
                completion(true)
            }
        }
    }
}
