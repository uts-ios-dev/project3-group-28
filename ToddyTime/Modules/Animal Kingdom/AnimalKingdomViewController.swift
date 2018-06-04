//
//  AnimalKingdomViewController.swift
//  ToddyTime
//
//  Created by Shankhar on 5/22/18.
//  Copyright © 2018 Shankhar. All rights reserved.
//

import UIKit

class AnimalKingdomViewController: UIViewController {

    static let identifier = "AnimalKingdomViewController"
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var animalDisplayView: UIView!
    @IBOutlet weak var soundButton: UIButton!
    
    var viewModel = AnimalKingdomViewModel()
    private var objectButtons = [ObjectButton]()
    
    
    //MARK: - CONTROLLER LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
    }
    
    
    //MARK: - PRIVATE FUNCTIONS
    
    //setup view for first time
    private func setupView() {
        soundButton.setImage(AudioHandler.muteAppMusic ? #imageLiteral(resourceName: "mute") : #imageLiteral(resourceName: "sound"), for: .normal)
        viewModel = AnimalKingdomViewModel(frame: animalDisplayView.frame)
        loadNextRound()
    }
    
    private func loadNextRound() {
        removeAllButton()
        if viewModel.setupNextRound() {
            addNewAnimalButton()
            self.answerLabel.text = viewModel.correctAnimal
        } else {
            pushEndPageController()
        }
    }
    
    
    //push end page controller
    fileprivate func pushEndPageController() {
        if let endPagController = self.storyboard?.instantiateViewController(withIdentifier: EndPageViewController.identifier) as? EndPageViewController {
            endPagController.learnedObject = self.viewModel.correctAnimals
            self.navigationController?.pushViewController(endPagController, animated: true)
        }
    }
    
    
    //removes all Button
    private func removeAllButton() {
        for eachButton in objectButtons {
            eachButton.removeFromSuperview()
        }
        objectButtons = [ObjectButton]()
    }
    
    
    //loads buttons at random position
    private func addNewAnimalButton() {
        for index in 0 ..< AppDefault.totalNumberOfAnimalsDisplayed {
            let objectButton = ObjectButton(withOrigin: viewModel.randomPoints[index], object: viewModel.randomAnimals[index])
            
            objectButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
            self.animalDisplayView.addSubview(objectButton)
            objectButton.showBubble(completion: nil)
            objectButtons.append(objectButton)
        }
    }
    
    
    //MARK: - BUTTON EVENTS
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func soundTapped(_ sender: UIButton) {
        AudioHandler.muteAppMusic = !AudioHandler.muteAppMusic
        sender.setImage(AudioHandler.muteAppMusic ? #imageLiteral(resourceName: "mute") : #imageLiteral(resourceName: "sound"), for: .normal)
    }
    
    
    //action after animal buttons are tapped
    @objc func buttonTapped(sender: ObjectButton) {
        if sender.object == viewModel.correctAnimal {
            sender.popBubble(completion: {
                sender.isHidden = true
                sender.removeFromSuperview()
                AudioHandler.play(audio: sender.object)
                self.loadNextRound()
            })
        }
    }
}
