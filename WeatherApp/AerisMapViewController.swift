//
//  AerisMapViewController.swift
//  WeatherApp
//
//  Created by User on 8/27/16.
//  Copyright © 2016 User. All rights reserved.
//

import UIKit
import AerisMap
import AerisUI
import Aeris

class AerisMapViewController: AWFWeatherMapViewController, AWFWeatherMapDelegate {

    var lat = Double(0)
    var lon = Double(0)
    @IBOutlet weak var mapBase: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        self.weatherMap.setMapCenter(center, zoomLevel: 8, animated: false)
        self.weatherMap.add(AWFLayerType.typeRadar)
        self.weatherMap.add(AWFLayerType.typeSatellite)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.blue
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
