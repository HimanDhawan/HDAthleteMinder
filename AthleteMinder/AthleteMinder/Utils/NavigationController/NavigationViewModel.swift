//
//  NavigationViewModel.swift
//  AthleteMinder
//
//  Created by Himan Dhawan on 15/09/21.
//

import Foundation
import UIKit

// MARK: - View Model

class NavigationViewModel {
    
    init() {
        
    }
    
}

// MARK: - Public Functions

extension NavigationViewModel {
    
    var navigationTintColor : UIColor? {
        UIColor.init(named: "NavigationTintColor", in: Bundle.init(for: CustomNavigationController.self), compatibleWith: nil)
    }
    var navigationBarTintColor : UIColor? {
        UIColor.init(named: "NavigationBackground", in: Bundle.init(for: CustomNavigationController.self), compatibleWith: nil)
    }
    
    var navigationForeGroundColor : UIColor? {
        UIColor.init(named: "NavigationTintColor", in: Bundle.init(for: CustomNavigationController.self), compatibleWith: nil)
    }
    
    var titleFont : UIFont? {
        UIFont.init(name: DINFont.mediumCondensed.getFontString(), size: 24)
    }
    
}
