//
//  Next7DaysTableViewCell.swift
//  CSCI571 HW9
//
//  Created by User on 11/18/15.
//  Copyright © 2015 User. All rights reserved.
//

import UIKit

class Next7DaysTableViewCell: UITableViewCell {

    @IBOutlet weak var timing: UILabel!
    @IBOutlet weak var minMaxTemp: UILabel!
    @IBOutlet weak var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
