//
//  SupportFunction.swift
//  CSCI571 HW9
//
//  Created by User on 11/14/15.
//  Copyright © 2015 User. All rights reserved.
//

import Foundation
import UIKit

func resizeImage(_ image: UIImage, newWidth: CGFloat) -> UIImage {    
    let scale = newWidth / image.size.width
    let newHeight = image.size.height * scale
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
}
