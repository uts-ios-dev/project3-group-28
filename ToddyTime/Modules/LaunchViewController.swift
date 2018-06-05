//
//  LaunchViewController.swift
//  ToddyTime
//
//  Created by Shankhar on 6/2/18.
//  Copyright © 2018 Shankhar. All rights reserved.
//

import UIKit

/// First page launched by app
class LaunchViewController: UIViewController {

    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var animalKindomLabel: UILabel!
    @IBOutlet weak var picturePlayLabel: UILabel!
    @IBOutlet weak var gapConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topConstraint.constant = self.view.frame.height/2
        gapConstraint.constant = UIDevice.current.orientation.isPortrait ? 100 : 20
        soundButton.setImage(AudioHandler.muteAppMusic ? #imageLiteral(resourceName: "mute") : #imageLiteral(resourceName: "sound"), for: .normal)
        animalKindomLabel.layer.cornerRadius = 15.0
        picturePlayLabel.layer.cornerRadius = 15.0
        animalKindomLabel.layer.masksToBounds = true
        picturePlayLabel.layer.masksToBounds = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        topConstraint.constant = 130.0
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    //change view when device changes orientation
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        gapConstraint.constant = UIDevice.current.orientation.isPortrait ? 100 : 20
    }
    
    
    //MARK: - BUTTON TAPPED EVENTS
    
    @IBAction func muteTapped(_ sender: UIButton) {
        AudioHandler.muteAppMusic = !AudioHandler.muteAppMusic
        soundButton.setImage(AudioHandler.muteAppMusic ? #imageLiteral(resourceName: "mute") : #imageLiteral(resourceName: "sound"), for: .normal)
    }
    
    //redirect to animal kingdom game
    @IBAction func animalKingdomTapped(_ sender: Any) {
        if let animalKingdomController = self.storyboard?.instantiateViewController(withIdentifier: AnimalKingdomViewController.identifier) as? AnimalKingdomViewController {
            self.navigationController?.pushViewController(animalKingdomController, animated: true)
        }
    }
    
    
    //redirects to picture play game
    @IBAction func picturePlayPressed(_ sender: Any) {
        if let picturePlayController = self.storyboard?.instantiateViewController(withIdentifier: PicturePlayViewController.identifier) as? PicturePlayViewController {
            self.navigationController?.pushViewController(picturePlayController, animated: true)
        }
    }
}
