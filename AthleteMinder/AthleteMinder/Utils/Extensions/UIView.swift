//
//  UIView.swift
//  AthleteMinder
//
//  Created by Himan Dhawan on 15/09/21.
//

import Foundation
import UIKit

extension UIView {
    func overlaps(other view: UIView, in viewController: UIViewController) -> Bool {
        let frame = self.convert(self.bounds, to: viewController.view)
        let otherFrame = view.convert(view.bounds, to: viewController.view)
        return frame.intersects(otherFrame)
    }
}
