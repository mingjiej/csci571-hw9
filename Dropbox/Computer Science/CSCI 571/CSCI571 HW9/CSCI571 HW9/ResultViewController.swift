//
//  ResultViewController.swift
//  CSCI571 HW9
//
//  Created by User on 11/12/15.
//  Copyright © 2015 User. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKShareKit
class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FBSDKSharingDelegate {
    
//    @IBOutlet weak var icon: UIImageView!
    //
    @IBOutlet weak var background: UIImageView!
    var contentURL = "http://www.brianjcoleman.com/tutorial-how-to-share-in-facebook-sdk-4-0-for-swift"
    var contentURLImage = "http://www.brianjcoleman.com/wp-content/uploads/2015/03/10734326_939301926101159_1211166514_n-667x333.png"
    var contentTitle = ""
    var contentDescription = "In this tutorial learn how to integrate Facebook Sharing into your iOS Swift project using the native Facebook SDK 4.0."
    //
    @IBOutlet weak var tableView: UITableView!
    var detail24Hours : [Next24Hours] = []
    var detail7days : [Next7Days] = []
    var today : [String:String] = [:]
    var todaytitle = ["Precipitation", "Chance of Rain", "Wind Speed", "Dew Point", "Humidlity", "Visibility", "Sunrise", "Sunset"]
    var todaydetail = [String]()
    var lon = Double(0)
    var lat = Double(0)
    var degree = ""
    @IBOutlet weak var fbbutton: UIBarButtonItem!
    let FBicon = UIImage(named: "fb_icon_small.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
    //    @IBOutlet weak var fblogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        fbbutton.image = FBicon
        todaydetail = [today["precipitation"]!, today["precipProbability"]!, today["windspeed"]!, today["dewPoint"]!, today["humidity"]!, today["visibility"]!, today["sunrise"]!, today["sunset"]!]
        let tblView =  UIView(frame: CGRectZero)
        tableView.tableFooterView = tblView
        tableView.tableFooterView!.hidden = true
        tableView.backgroundColor = UIColor.clearColor()
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        if(FBSDKAccessToken.currentAccessToken()==nil) {
            print("not log in")
        } else {
            print("log in")
        }
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
    @IBAction func sharePost(sender: UIBarButtonItem) {
        
        contentTitle = "Current Weather in " + today["city"]! + ", " + today["state"]!
        contentDescription = today["summery"]! + ", " + today["temperature"]!
        contentURL = "http://forecast.io"
        contentURLImage = "http://cs-server.usc.edu:45678/hw/hw8/images/" + today["currenticon"]!
        let content: FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: self.contentURL)
        content.contentTitle = self.contentTitle
        content.contentDescription = self.contentDescription
        content.imageURL = NSURL(string: self.contentURLImage)
        let dialog = FBSDKShareDialog()
        dialog.mode = FBSDKShareDialogMode.FeedWeb
        dialog.shareContent = content
        dialog.delegate = self
        dialog.fromViewController = self
        dialog.show()
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todaytitle.count + 1;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("header")! as! TodayHeaderTableViewCell
            cell.icon.contentMode = .ScaleAspectFill
            let weathericon = UIImage(named: self.today["currenticon"]!)
            cell.icon.image = resizeImage(weathericon!, newWidth:100)
            cell.summery.text = today["summery"]! + " in " + today["city"]! + ", " + today["state"]!
            cell.temperature.text = today["temperature"]
            cell.maxMin.text = "L: " + today["lowtemp"]! + " | H: " + today["maxtemp"]!
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clearColor()
            cell.selectedBackgroundView = bgColorView
            return cell
        } else {
            let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("todayDetail")! as UITableViewCell
            cell.textLabel?.text = self.todaytitle[indexPath.row-1]
            cell.detailTextLabel?.text = self.todaydetail[indexPath.row-1]
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clearColor()
            cell.selectedBackgroundView = bgColorView
            return cell
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        navigationController?.hidesBarsOnTap = false;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showDetail") {
            let svc = segue.destinationViewController as! DetailViewController
            svc.detail24Hours = detail24Hours
            svc.detail7days = detail7days
            svc.degree = degree
        }
        if (segue.identifier == "showMap") {
            let svc = segue.destinationViewController as! AerisMapViewController
            svc.lon = lon
            svc.lat = lat
        }
    }
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject: AnyObject]) {
        if results["postId"] != nil {
            let alert = UIAlertController(
                title: "Facebook Response",
                message: "Customer post is complete!",
                preferredStyle: UIAlertControllerStyle.Alert
            )
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(
                title: "Facebook Response",
                message: "Customer post is canceled!",
                preferredStyle: UIAlertControllerStyle.Alert
            )
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        let alert = UIAlertController(
            title: "Facebook Response",
            message: "Customer post is failed!",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
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
