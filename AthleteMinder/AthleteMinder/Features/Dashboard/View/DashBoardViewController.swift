//
//  DashBoardViewController.swift
//  AthleteMinder
//
//  Created by Himan Dhawan on 15/09/21.
//

import UIKit

class DashBoardViewController: UIViewController {

    let viewModel : DashBoardViewModel = DashBoardViewModel.init()
    
    /// IBOutlets
    @IBOutlet weak var parentContainerView: UIView!
    @IBOutlet weak var trainingButton: UIButton!
    @IBOutlet weak var competitionButton: UIButton!
    @IBOutlet weak var pulseButton: UIButton!
    @IBOutlet weak var trainingLabel: UILabel!
    @IBOutlet weak var competitionLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var restButton: UIButton!
    
    @IBOutlet weak var restBackGroundView: UIView!
    @IBOutlet weak var trainingBackGroundView: UIView!
    @IBOutlet weak var competitionBackGroundView: UIView!
    
    /// Private Variables
    
}

// MARK: - View Controller Life Cycle
extension DashBoardViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beginAnimation()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpView()
        self.setUpGesture()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func beginAnimation() {
        self.pulseButton.createPulse()
    }
    
    func setUpGesture() {
        self.competitionButton.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(competitionPanGesturehandler)))
        self.trainingButton.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(trainingPanGesturehandler)))
    }
    
    func setUpView() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: .init(named: "Menu-Icon"), style: .plain, target: self, action: #selector(menuTapped))
    }
        
    @objc func menuTapped()  {
        // No work required
    }
    
}

// MARK: - IBActions
extension DashBoardViewController {
    
    @IBAction func ringbuttonPressed(_ sender: UIButton) {
        
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
    }
    
}

// MARK: - Drag Function
extension DashBoardViewController {
    @objc func competitionPanGesturehandler(gesture: UIPanGestureRecognizer){
        self.panGestureRecognized(button: self.competitionButton, backgrounView: self.competitionBackGroundView, gesture: gesture)
    }
    
    @objc func trainingPanGesturehandler(gesture: UIPanGestureRecognizer){
        self.panGestureRecognized(button: self.trainingButton, backgrounView: self.trainingBackGroundView, gesture: gesture)
    }
    
    func panGestureRecognized(button : UIButton, backgrounView : UIView, gesture : UIPanGestureRecognizer ) {
        let location = gesture.location(in: self.view)
        let draggedView = gesture.view
        draggedView?.center = location
        
        if gesture.state == .ended {
            
            let isOverlapping =  button.overlaps(other: self.pulseButton, in: self)
            self.realsePickedButton(button: button)
            if isOverlapping {
                self.sharpPulseButton()
                self.pulseButton.removePulse()
                self.animateToPulseButton(button: button)
                self.animateViewWithGastureEndedAndOverLapped(button: button)
            } else {
                self.animateToOrigianlView(button: button, view: backgrounView)
                self.animateViewWithGastureEnded(button: button)
            }
            
            
        } else if gesture.state == .began {
            self.animateViewWithGastureBegin(button: button)
        } else {
            let isOverlapping =  button.overlaps(other: self.pulseButton, in: self)
            if isOverlapping {
                self.dimPulseButton()
            } else {
                self.sharpPulseButton()
                self.pulseButton.createPulse()
            }
        }
    }
    
}


// MARK: - Navigation Functions
extension DashBoardViewController {
    
    func goToTrainingModule()  {
        
        if let viewController = self.viewModel.trainingViewController {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}

// MARK: - Util Functions
extension DashBoardViewController {
    
    func animateViewWithGastureBegin(button : UIButton) {
        switch button.tag {
        case self.viewModel.trainingButtonTag: self.squeezeCompetionAndRestButton()
        case self.viewModel.competitionButtonTag: self.squeezeTrainingAndRestButton()
        case self.viewModel.restButtonTag: break /// Not added gesture for rest button
        default:break
        }
        self.expandPickedButton(button: button)
        self.hideAllLabel()
    }
    
    func animateViewWithGastureEnded(button : UIButton) {
        switch button.tag {
        case self.viewModel.trainingButtonTag: self.releaseCompetionAndRestButton()
        case self.viewModel.competitionButtonTag: self.releaseTrainingAndRestButton()
        case self.viewModel.restButtonTag: break /// Not added gesture for rest button
        default:break
        }
        
        self.showAllLabel()
    }
    
    func animateViewWithGastureEndedAndOverLapped(button : UIButton) {
        switch button.tag {
        case self.viewModel.trainingButtonTag: self.releaseCompetionAndRestButton() ; showCompetionAndRestLabel()
        case self.viewModel.competitionButtonTag: self.releaseTrainingAndRestButton() ; showTrainingAndRestLabel()
        case self.viewModel.restButtonTag: break /// Not added gesture for rest button
        default:break
        }
    }
    
    func squeezeCompetionAndRestButton()  {
        
        self.competitionButton.squeeze(completion: nil)
        self.restButton.squeeze(completion: nil)
        
    }
    
    func squeezeTrainingAndRestButton()  {
        
        self.trainingButton.squeeze(completion: nil)
        self.restButton.squeeze(completion: nil)
        
    }
    
    
    func releaseCompetionAndRestButton()  {
        
        self.competitionButton.release(completion: nil)
        self.restButton.release(completion: nil)
        
    }
    
    func releaseTrainingAndRestButton()  {
        
        self.trainingButton.release(completion: nil)
        self.restButton.release(completion: nil)
        
    }
    
    func expandPickedButton(button : UIButton)  {
        button.enlarge(completion: nil)
    }
    
    func realsePickedButton(button : UIButton)  {
        button.release(completion: nil)
    }
    
    func dimPulseButton()  {
        UIView.animate(withDuration: self.viewModel.showHideAnimationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.pulseButton.alpha = 0.5
        }, completion: nil)
    }
    
    func sharpPulseButton()  {
        UIView.animate(withDuration: self.viewModel.showHideAnimationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.pulseButton.alpha = 1
        }, completion: nil)
    }
    
    func hideAllLabel()  {
        UIView.animate(withDuration: self.viewModel.showHideAnimationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.trainingLabel.alpha = 0.0
            self.restLabel.alpha = 0.0
            self.competitionLabel.alpha = 0.0
        }, completion: nil)
    }
    
    func showAllLabel()  {
        UIView.animate(withDuration: self.viewModel.showHideAnimationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.restLabel.alpha = 1.0
            self.trainingLabel.alpha = 1.0
            self.competitionLabel.alpha = 1.0
        }, completion: nil)
    }
    
    func showCompetionAndRestLabel()  {
        UIView.animate(withDuration: self.viewModel.showHideAnimationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.restLabel.alpha = 1.0
            self.competitionLabel.alpha = 1.0
        }, completion: nil)
    }
    
    func showTrainingAndRestLabel()  {
        UIView.animate(withDuration: self.viewModel.showHideAnimationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.restLabel.alpha = 1.0
            self.trainingLabel.alpha = 1.0
        }, completion: nil)
    }
    
    func animateToPulseButton(button: UIButton)  {
        
        UIView.animate(withDuration: self.viewModel.showHideAnimationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn) {
            button.center = self.pulseButton.center
        } completion: { _ in
            self.goToTrainingModule()
        }
        
    }
    
    func animateToOrigianlView(button: UIButton, view : UIView)  {
        
        UIView.animate(withDuration: self.viewModel.showHideAnimationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            button.frame = view.frame
        }, completion: nil)
    }
}
