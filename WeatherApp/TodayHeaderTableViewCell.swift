//
//  TodayHeaderTableViewCell.swift
//  CSCI571 HW9
//
//  Created by User on 11/14/15.
//  Copyright © 2015 User. All rights reserved.
//

import UIKit

class TodayHeaderTableViewCell: UITableViewCell {
    //
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var maxMin: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var summery: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        icon.clipsToBounds = true;
        icon.contentMode = .scaleAspectFill
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
