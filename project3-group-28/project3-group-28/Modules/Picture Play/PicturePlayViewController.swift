//
//  PicturePlayViewController.swift
//  ToddyTime
//
//  Created by Shankhar on 5/27/18.
//  Copyright © 2018 Shankhar. All rights reserved.
//

import UIKit

class PicturePlayViewController: UIViewController {
    
    static let identifier = "PicturePlayViewController"
    
    @IBOutlet weak var animalDisplayView: UIView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var thingsListView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var thingsListHeight: NSLayoutConstraint!
    @IBOutlet weak var soundButton: UIButton!
    
    var viewModel = PicturePlayViewModel()
    
    var objectButtons = [ObjectButton]()
    var numberOfAvailableObject = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
        soundButton.setImage(AudioHandler.muteAppMusic ? #imageLiteral(resourceName: "mute") : #imageLiteral(resourceName: "sound"), for: .normal)
        viewModel = PicturePlayViewModel(frame: animalDisplayView.frame)
        loadAnimal()
    }
    
    func refresh() {
        
        for eachButton in objectButtons {
            eachButton.removeFromSuperview()
        }
        objectButtons = [ObjectButton]()
        viewModel = PicturePlayViewModel(frame: animalDisplayView.frame)
        loadAnimal()
    }
    
    
    
    func loadAnimal() {
        for index in 0 ..< viewModel.totalNumberOfAnimalDisplayed {
            let objectButton = ObjectButton(withOrigin: viewModel.randomPoints[index], object: viewModel.randomObjects[index])
            
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
    
    @IBAction func muteTapped(_ sender: UIButton) {
        AudioHandler.muteAppMusic = !AudioHandler.muteAppMusic
        sender.setImage(AudioHandler.muteAppMusic ? #imageLiteral(resourceName: "mute") : #imageLiteral(resourceName: "sound"), for: .normal)
    }
    
    @objc func buttonTapped(sender: ObjectButton) {
        sender.popBubble(completion: {
            sender.isHidden = true
            sender.removeFromSuperview()
            AudioHandler.play()
            self.viewModel.selectObject(object: sender.object)
            self.tableView.reloadData()
            self.numberOfAvailableObject -= 1
            if self.numberOfAvailableObject == 0 {
                if let endPagController = self.storyboard?.instantiateViewController(withIdentifier: EndPageViewController.identifier) as? EndPageViewController {
                    endPagController.learnedObject = self.viewModel.randomObjects
                    endPagController.isAnimalKingdom = false
                    self.navigationController?.pushViewController(endPagController, animated: true)
                }
            }
        })
    }
}

extension PicturePlayViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.randomObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell {
            cell.create(withTitle: viewModel.randomObjects[indexPath.row], isChecked: viewModel.isRandomObjectSelected[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
}
