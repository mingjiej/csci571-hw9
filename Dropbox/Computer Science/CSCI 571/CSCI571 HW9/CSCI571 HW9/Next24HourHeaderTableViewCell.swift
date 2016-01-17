//
//  Next24HourHeaderTableViewCell.swift
//  CSCI571 HW9
//
//  Created by User on 11/17/15.
//  Copyright © 2015 User. All rights reserved.
//

import UIKit

class Next24HourHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var summery: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
