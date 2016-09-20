//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by User on 9/14/16.
//  Copyright © 2016 User. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var detail24Hours : [Next24Hours] = []
    var detail7days : [Next7Days] = []
    var rownumber = Int(0);
    var degree = ""
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var segmentSwitch: UISegmentedControl!
    @IBOutlet weak var day7ViewController: UITableView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var tableView: UITableView!
//
    @IBOutlet weak var TempLable: UILabel!
//
    override func viewDidLoad() {
        super.viewDidLoad()
        let tblView =  UIView(frame: CGRect.zero)
        tableView.tableFooterView = tblView
        tableView.tableFooterView!.isHidden = true
        tableView.backgroundColor = UIColor.clear
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        day7ViewController.tableFooterView = tblView
        day7ViewController.tableFooterView!.isHidden = true
        day7ViewController.backgroundColor = UIColor.clear
        day7ViewController.estimatedRowHeight = 100
        day7ViewController.rowHeight = UITableViewAutomaticDimension
        day7ViewController.isHidden = true
//        tableViewTemp.hidden = true
        rownumber = detail24Hours.count/2+1
        TempLable.text = "Temp (" + "\u{00B0}" + degree + ")"
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        let blurredImage = UIImage(named: "Photo Dec 06, 11 30 24.jpg")!.applyBlurWithRadius(
            CGFloat(10),
            tintColor: nil,
            saturationDeltaFactor: 1.0,
            maskImage: nil
        )
        print("now we have \(detail24Hours.count) hours")
        background.image = blurredImage
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0) {
            day7ViewController.isHidden = true
            tableView.isHidden = false
            toolbar.isHidden = false
            headerView.isHidden = false
        } else {
            tableView.isHidden = true
            toolbar.isHidden = true
            day7ViewController.isHidden = false
            headerView.isHidden = true
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.tableView) {
            return rownumber
        } else {
            return detail7days.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == self.tableView) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "next24hourbody")! as! Next24HourCell
            cell.time.text = detail24Hours[(indexPath as NSIndexPath).row].getTime()
            cell.temp.text = detail24Hours[(indexPath as NSIndexPath).row].getTemperature()
            let tempIcon = detail24Hours[(indexPath as NSIndexPath).row].getImage()
            cell.icon.image = resizeImage(tempIcon, newWidth: 50)
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = bgColorView
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Next7Days")! as! Next7DaysTableViewCell
            cell.timing.text = detail7days[(indexPath as NSIndexPath).row].getTime()
            cell.minMaxTemp.text = "Min: " + detail7days[(indexPath as NSIndexPath).row].getMinTemperature() + " | " + "Max: " + detail7days[(indexPath as NSIndexPath).row].getMaxTemperature()
            let tempIcon = detail7days[(indexPath as NSIndexPath).row].getImage()
            cell.icon.image = resizeImage(tempIcon, newWidth: 70)
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = bgColorView
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
    @IBAction func ReloadMore(_ sender: UIBarButtonItem) {
        rownumber = detail24Hours.count
        tableView.reloadData()
    }

}
