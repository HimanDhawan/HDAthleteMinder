//
//  ViewControllerViewModel.swift
//  AthleteMinder
//
//  Created by Himan Dhawan on 15/09/21.
//

import Foundation
import UIKit

// MARK: - View Model

class ViewControllerViewModel {
    
    init() {
        
    }
    
}

// MARK: - Public Functions

extension ViewControllerViewModel {
    
    var loginButtonTag : Int {
        return 0
    }
    var skipButtonTag : Int {
        return 1
    }
    
    var dashBoardViewContoller : DashBoardViewController? {
        let storyBoard = UIStoryboard (
            name: "Main", bundle: Bundle(for: ViewController.self)
        )
        let viewController = storyBoard.instantiateViewController(withIdentifier: "DashBoardViewController") as? DashBoardViewController
        
        guard let dashBoardViewController = viewController else {
            return nil
        }
        return dashBoardViewController
    }
    
    var labelShowAnimationTimeDuration : Double {
        return 1
    }
    
}
