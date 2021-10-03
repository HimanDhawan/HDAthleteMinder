//
//  ViewController.swift
//  AthleteMinder
//
//  Created by Himan Dhawan on 13/09/21.
//

import UIKit

class ViewController: UIViewController {

    /// View Model
    let viewModel = ViewControllerViewModel.init()
    
    /// IBOutlets
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var createMyProfileContainerView: UIView!
    @IBOutlet weak var athleteMinderLabel: UILabel!
    @IBOutlet weak var mindYourSportLabel: UILabel!
    @IBOutlet weak var createMyProfileButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var termsAndConditionView: UIView!
    
}

// MARK: - View Controller Life Cycle
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.beginAnimation()
    }
    
    func setUpView() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

// MARK: - Animation Functions
extension ViewController {
    
    func beginAnimation() {
        self.logoImage.animate { _ in
            self.showContainerView()
        }
    }
    
    func showContainerView() {
        self.hideCreateProfileAndSkipButton()
        self.createMyProfileContainerView.alpha = 0.0
        self.termsAndConditionView.alpha = 0.0
        UIView.animate(withDuration: self.viewModel.labelShowAnimationTimeDuration) {
            self.createMyProfileContainerView.alpha = 1.0
        } completion: { _ in
            self.showCreateProfileButton()
            self.flipCreateProfileButton()
        }
    }
    
    func hideCreateProfileAndSkipButton() {
        self.createMyProfileButton.alpha = 0.0
        self.skipButton.alpha = 0.0
    }
    
    func showTermsAndConditionView() {
        UIView.animate(withDuration: self.viewModel.labelShowAnimationTimeDuration) {
            self.termsAndConditionView.alpha = 1.0
        } completion: { _ in
            
        }
    }
    
    func showCreateProfileButton() {
        self.createMyProfileButton.alpha = 1.0
    }
    
    func showSkipButton() {
        self.skipButton.alpha = 1.0
    }
    
    func flipCreateProfileButton() {
        self.createMyProfileButton.flip(buttonTag: viewModel.loginButtonTag, animationDelegate: self)
    }
    
    func flipSkipButtons() {
        self.skipButton.flip(buttonTag: viewModel.skipButtonTag, animationDelegate: self)
    }
    
}

// MARK: - IBActions
extension ViewController {
    @IBAction func createMyProfileButtonPressed(_ sender: UIButton) {
        if let controller = self.viewModel.dashBoardViewContoller {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

// MARK: - CAAnimationDelegate
extension ViewController : CAAnimationDelegate {
    
    func animationDidStart(_ anim: CAAnimation) {
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if let tag = anim.value(forKey: "tag") as? Int  {
            switch tag {
            case 0: do {
                self.showSkipButton()
                self.flipSkipButtons()
            }
            case 1: do {
                self.showTermsAndConditionView()
            }
                
            default: break
                
            }
        }
        
    }
    
}
