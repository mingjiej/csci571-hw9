//
//  Next24HourCell.swift
//  CSCI571 HW9
//
//  Created by User on 11/17/15.
//  Copyright © 2015 User. All rights reserved.
//

import UIKit

class Next24HourCell: UITableViewCell {
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var temp: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
