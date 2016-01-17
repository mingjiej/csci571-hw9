//
//  detailViewController.swift
//  CSCI571 HW9
//
//  Created by User on 11/17/15.
//  Copyright © 2015 User. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var detail24Hours : [Next24Hours] = []
    var detail7days : [Next7Days] = []
    var rownumber = Int(0);
    var degree = ""
    @IBOutlet weak var segmentSwitch: UISegmentedControl!
    
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var day7ViewController: UITableView!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var headerView: UIView!
 
    @IBOutlet weak var tableViewTemp: UITableView!
    
    @IBOutlet weak var TempLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tblView =  UIView(frame: CGRectZero)
        tableView.tableFooterView = tblView
        tableView.tableFooterView!.hidden = true
        tableView.backgroundColor = UIColor.clearColor()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        day7ViewController.tableFooterView = tblView
        day7ViewController.tableFooterView!.hidden = true
        day7ViewController.backgroundColor = UIColor.clearColor()
        day7ViewController.estimatedRowHeight = 100
        day7ViewController.rowHeight = UITableViewAutomaticDimension
        day7ViewController.hidden = true
        tableViewTemp.hidden = true
        rownumber = detail24Hours.count/2+1
        TempLable.text = "Temp (" + "\u{00B0}" + degree + ")"
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = true
        let blurredImage = UIImage(named: "Photo Dec 06, 11 30 24.jpg")!.applyBlurWithRadius(
            CGFloat(10),
            tintColor: nil,
            saturationDeltaFactor: 1.0,
            maskImage: nil
        )
        background.image = blurredImage
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    @IBAction func segmentControl(sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0) {
            day7ViewController.hidden = true
            tableView.hidden = false
            toolbar.hidden = false
            headerView.hidden = false
        } else {
            tableView.hidden = true
            toolbar.hidden = true
            day7ViewController.hidden = false
            headerView.hidden = true
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.tableView) {
            return rownumber
        } else {
            return detail7days.count
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(tableView == self.tableView) {
            let cell = tableView.dequeueReusableCellWithIdentifier("next24hourbody")! as! Next24HourCell
            cell.time.text = detail24Hours[indexPath.row].getTime()
            cell.temp.text = detail24Hours[indexPath.row].getTemperature()
            let tempIcon = detail24Hours[indexPath.row].getImage()
            cell.icon.image = resizeImage(tempIcon, newWidth: 50)
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clearColor()
            cell.selectedBackgroundView = bgColorView
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Next7Days")! as! Next7DaysTableViewCell
            cell.timing.text = detail7days[indexPath.row].getTime()
            cell.minMaxTemp.text = "Min: " + detail7days[indexPath.row].getMinTemperature() + " | " + "Max: " + detail7days[indexPath.row].getMaxTemperature()
            let tempIcon = detail7days[indexPath.row].getImage()
            cell.icon.image = resizeImage(tempIcon, newWidth: 70)
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clearColor()
            cell.selectedBackgroundView = bgColorView
            return cell
        }
        
    }
    @IBAction func ReloadMore(sender: UIBarButtonItem) {
        rownumber = detail24Hours.count
        tableView.reloadData()
    }

}
