//
//  TableViewCell.swift
//  ToddyTime
//
//  Created by Shankhar on 5/27/18.
//  Copyright © 2018 Shankhar. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tickImage: UIImageView!
    
    
    func create(withTitle title: String, isChecked: Bool = false) {
        titleLabel.text = title
        tickImage?.isHidden = !isChecked
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
