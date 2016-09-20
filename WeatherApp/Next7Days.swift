//
//  Next7Days.swift
//  CSCI571 HW9
//
//  Created by User on 11/17/15.
//  Copyright © 2015 User. All rights reserved.
//

import Foundation
import UIKit
class Next7Days {
    var icon = UIImage();
    var time = String();
    var mintemp = String();
    var maxtemp = String();
    init(pic: String, timing: String, mintemperature: String, maxtemperature: String) {
        icon = UIImage(named: pic)!
        time = timing
        mintemp = mintemperature
        maxtemp = maxtemperature
    }
    func getImage() -> UIImage {
        return icon
    }
    func getTime() -> String {
        return time
    }
    func getMinTemperature() -> String {
        return mintemp
    }
    func getMaxTemperature() -> String {
        return maxtemp
    }

}