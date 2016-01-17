//
//  TodayHeaderTableViewCell.swift
//  CSCI571 HW9
//
//  Created by User on 11/14/15.
//  Copyright © 2015 User. All rights reserved.
//

import UIKit

class TodayHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var summery: UILabel!
    @IBOutlet weak var maxMin: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
//        icon.clipsToBounds = true;
        icon.contentMode = .ScaleAspectFill
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
