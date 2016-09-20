//
//  Next24Hours.swift
//  CSCI571 HW9
//
//  Created by User on 11/17/15.
//  Copyright © 2015 User. All rights reserved.
//

import Foundation
import UIKit

class Next24Hours {
    var icon = UIImage();
    var time = String();
    var temp = String();
    init(pic: String, timing: String, temperature: String) {
        icon = UIImage(named: pic)!
        time = timing
        temp = temperature
    }
    func getImage() -> UIImage {
        return icon
    }
    func getTime() -> String {
        return time
    }
    func getTemperature() -> String {
        return temp
    }
}
