//
//  SupportFunction.swift
//  CSCI571 HW9
//
//  Created by User on 11/14/15.
//  Copyright © 2015 User. All rights reserved.
//

import Foundation
import UIKit

func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {    
    let scale = newWidth / image.size.width
    let newHeight = image.size.height * scale
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
    image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
}