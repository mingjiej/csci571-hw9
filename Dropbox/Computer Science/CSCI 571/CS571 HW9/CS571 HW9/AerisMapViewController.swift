//
//  AerisMapViewController.swift
//  CS571 HW9
//
//  Created by User on 11/23/15.
//  Copyright © 2015 User. All rights reserved.
//

import UIKit

class AerisMapViewController: AWFWeatherMapViewController, AWFWeatherMapDelegate{
    var lat = Double(0)
    var lon = Double(0)
    @IBOutlet weak var mapBase: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.blueColor()
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        self.weatherMap.setMapCenterCoordinate(center, zoomLevel: 8, animated: false)
        self.weatherMap.addLayerType(AWFLayerType.Radar)
        self.weatherMap.addLayerType(AWFLayerType.Satellite)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
