//
//  CustomNavigationController.swift
//  AthleteMinder
//
//  Created by Himan Dhawan on 15/09/21.
//


import Foundation
import UIKit


class CustomNavigationController: UINavigationController {
    
    let viewModel : NavigationViewModel = NavigationViewModel.init()
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.setUpNavigationBar()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpNavigationBar()
    }
    
}

// MARK: - Util Functions

extension CustomNavigationController {
    func setUpNavigationBar() {
        self.setUpTintColorAndBackgroundColor()
        self.setUpHeadingStyle()
    }
    
    func setUpTintColorAndBackgroundColor() {
        
        self.navigationBar.tintColor = self.viewModel.navigationTintColor
        
        self.navigationBar.barTintColor = self.viewModel.navigationBarTintColor
        
    }
    
    func setUpHeadingStyle() {
        var attrs : [NSAttributedString.Key : Any] = [:]
        attrs[NSAttributedString.Key.foregroundColor] =  self.viewModel.navigationForeGroundColor
        attrs[NSAttributedString.Key.font] =  self.viewModel.titleFont
        
        
        self.navigationBar.titleTextAttributes = attrs
    }
    
}


