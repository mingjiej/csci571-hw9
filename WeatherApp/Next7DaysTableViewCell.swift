//
//  Next7DaysTableViewCell.swift
//  WeatherApp
//
//  Created by User on 8/26/16.
//  Copyright © 2016 User. All rights reserved.
//

import UIKit

class Next7DaysTableViewCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var timing: UILabel!
    @IBOutlet weak var minMaxTemp: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

