//
//  DashBoardViewModel.swift
//  AthleteMinder
//
//  Created by Himan Dhawan on 16/09/21.
//

import Foundation
import UIKit

/// View Model

class DashBoardViewModel {
    init() {
        
    }
}

// MARK: - Public Functions

extension DashBoardViewModel {
    
    var trainingButtonTag : Int {
        return 101
    }
    
    var competitionButtonTag : Int {
        return 102
    }
    
    var restButtonTag : Int {
        return 103
    }
    
    var showHideAnimationDuration : Double {
        return 0.5
    }
    
    var trainingViewController : TrainingViewController? {
        let storyBoard = UIStoryboard (
            name: "Main", bundle: Bundle(for: ViewController.self)
        )
        let viewController = storyBoard.instantiateViewController(withIdentifier: "TrainingViewControllerID") as? TrainingViewController
        
        guard let trainingViewController = viewController else {
            return nil
        }
        return trainingViewController
    }
    
}
