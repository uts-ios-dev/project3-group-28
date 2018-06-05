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
    
    @IBOutlet weak var objectDisplayView: UIView!
    @IBOutlet weak var thingsListView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var thingsListHeight: NSLayoutConstraint!
    @IBOutlet weak var soundButton: UIButton!
    
    var viewModel = PicturePlayViewModel()
    private var objectButtons = [ObjectButton]()
    private var orientation = UIDevice.current.orientation
    
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
    }
    
    
    //regenerate button at new location on orientation change
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //if orientation of device is changed then update the view frame
        
        if orientation != UIDevice.current.orientation {
            orientation = UIDevice.current.orientation
            viewModel.updateFrame(with: objectDisplayView.bounds)
            removeAllButton()
            loadObject()
        }
        
    }
    
    
    //MARK: - PRIVATE FUNCTION
    
    //setup view and viewmodel
    private func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 40.0
        soundButton.setImage(AudioHandler.muteAppMusic ? #imageLiteral(resourceName: "mute") : #imageLiteral(resourceName: "sound"), for: .normal)
        viewModel = PicturePlayViewModel(frame: objectDisplayView.bounds)
        loadObject()
        tableView.reloadData()
    }
    
    //removes all Button
    private func removeAllButton() {
        for eachButton in objectButtons {
            eachButton.removeFromSuperview()
        }
        objectButtons = [ObjectButton]()
    }
    
    
    //redirect to end page controller
    fileprivate func redirectToEndPageController() {
        if let endPagController = self.storyboard?.instantiateViewController(withIdentifier: EndPageViewController.identifier) as? EndPageViewController {
            endPagController.learnedObject = self.viewModel.answerObjects
            endPagController.isAnimalKingdom = false
            self.navigationController?.pushViewController(endPagController, animated: true)
        }
    }
    
    
    // load object button on screen
    private func loadObject() {
        for index in 0 ..< AppDefault.totalNumberOfObjectDisplayed {
            let objectButton = ObjectButton(withOrigin: viewModel.randomPoints[index], object: viewModel.randomObjects[index])
            
            objectButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
            self.objectDisplayView.addSubview(objectButton)
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
    
    
    //event when button gets tapped
    @objc func buttonTapped(sender: ObjectButton) {
        if self.viewModel.answerObjects.contains(sender.object) {
            self.viewModel.selectObject(object: sender.object)
            self.tableView.reloadData()
            AudioHandler.play()
            sender.popBubble(completion: {
                //if all the answer are checked then
                if self.viewModel.isAllChecked {
                    self.redirectToEndPageController()
                }
            })
        } else {
            sender.alpha = 0.4
        }
    }
}


//MARK:- TABLEVIEW DATASOURCE AND DELEGATE

extension PicturePlayViewController: UITableViewDataSource, UITableViewDelegate {
    
    //returns number of object in list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.answerObjects.count
    }
    
    
    //returns cell for row in given indexpath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell {
            cell.create(withTitle: viewModel.answerObjects[indexPath.row], isChecked: viewModel.isRandomObjectSelected[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
}
