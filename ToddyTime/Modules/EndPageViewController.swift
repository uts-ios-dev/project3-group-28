//
//  EndPageViewController.swift
//  ToddyTime
//
//  Created by Shankhar on 5/27/18.
//  Copyright © 2018 Shankhar. All rights reserved.
//

import UIKit


/// Page that shows progress of users
class EndPageViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var button1Label: UILabel!
    @IBOutlet weak var button2Label: UILabel!
    
    static let identifier = "EndPageViewController"

    var isAnimalKingdom = true
    var learnedObject = [String]()      // learned object in this game
    
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button1Label.layer.cornerRadius = 15
        button1Label.layer.masksToBounds = true
        button2Label.layer.cornerRadius = 15
        button2Label.layer.masksToBounds = true
        
        
        //manage progress according to the game played
        if isAnimalKingdom {
            button1Label.backgroundColor = AppDefault.greenColor
            button1Label.textColor = AppDefault.whiteColor
            button2Label.text = "Picture Play"
            button2Label.backgroundColor = AppDefault.yellowColor
            button2Label.textColor = AppDefault.blackColor
            titleLabel.text = "Hooray you learned \(learnedObject.count) new animals today."
        } else {
            button2Label.backgroundColor = AppDefault.greenColor
            button2Label.textColor = AppDefault.whiteColor
            button2Label.text = "Animal Kingdom"
            button1Label.backgroundColor = AppDefault.yellowColor
            button1Label.textColor = AppDefault.blackColor
            titleLabel.text = "Hooray identified \(learnedObject.count) new things today."
        }
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    //MARK: - BUTTON EVENT
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender.tag == 1 {
            isAnimalKingdom ? loadAnimalKingdomPage() : loadPicturePlayPage()
        } else {
            isAnimalKingdom ? loadPicturePlayPage() : loadAnimalKingdomPage()
        }
    }
    
    
    //MARK: - PRIVATE FUNCTIONS
    
    
    // redirect to animal kingdom page
    private func loadAnimalKingdomPage() {
        if let animalKingdomController = storyboard?.instantiateViewController(withIdentifier: AnimalKingdomViewController.identifier) as? AnimalKingdomViewController {
            let rootController = self.navigationController?.viewControllers[0]
            self.navigationController?.setViewControllers([rootController!, animalKingdomController], animated: true)
        }
    }
    
    // redirect to picture play game
    private func loadPicturePlayPage() {
        if let picturePlayController = storyboard?.instantiateViewController(withIdentifier: PicturePlayViewController.identifier) as? PicturePlayViewController {
            let rootController = self.navigationController?.viewControllers[0]
            self.navigationController?.setViewControllers([rootController!, picturePlayController], animated: true)
        }
    }
    
}


//MARK: - TABLEVIEW DATASOURCE AND DELEGATE

extension EndPageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return learnedObject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell {
            cell.create(withTitle: learnedObject[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
