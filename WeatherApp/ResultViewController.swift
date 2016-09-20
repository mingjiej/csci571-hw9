//
//  ResultViewController.swift
//  WeatherApp
//
//  Created by User on 8/26/16.
//  Copyright © 2016 User. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKShareKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FBSDKSharingDelegate {


    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fbbutton: UIBarButtonItem!
    var detail24Hours : [Next24Hours] = []
    var detail7days : [Next7Days] = []
    var today : [String:String] = [:]
    var todaytitle = ["Precipitation", "Chance of Rain", "Wind Speed", "Dew Point", "Humidlity", "Visibility", "Sunrise", "Sunset"]
    var todaydetail = [String]()
    var lon = Double(0)
    var lat = Double(0)
    var degree = ""
    
    var contentURL = "http://www.brianjcoleman.com/tutorial-how-to-share-in-facebook-sdk-4-0-for-swift"
    var contentURLImage = "http://www.brianjcoleman.com/wp-content/uploads/2015/03/10734326_939301926101159_1211166514_n-667x333.png"
    var contentTitle = ""
    var contentDescription = "In this tutorial learn how to integrate Facebook Sharing into your iOS Swift project using the native Facebook SDK 4.0."
    let FBicon = UIImage(named: "fb_icon_small")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fbbutton.image = FBicon
        todaydetail = [today["precipitation"]!, today["precipProbability"]!, today["windspeed"]!, today["dewPoint"]!, today["humidity"]!, today["visibility"]!, today["sunrise"]!, today["sunset"]!]
        let tblView =  UIView(frame: CGRect.zero)
        tableView.tableFooterView = tblView
        tableView.tableFooterView!.isHidden = true
        tableView.backgroundColor = UIColor.clear
//        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        if(FBSDKAccessToken.current()==nil) {
            print("not log in")
        } else {
            print("log in")
        }
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        let blurredImage = UIImage(named: "Photo Dec 06, 11 30 24")!.applyBlurWithRadius(
            CGFloat(10),
            tintColor: nil,
            saturationDeltaFactor: 1.0,
            maskImage: nil
        )
//        tableView.registerClass(TodayHeaderTableViewCell.self, forCellReuseIdentifier: "header")
        background.image = blurredImage
        self.navigationController?.navigationBar.tintColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    @IBAction func sharePost(_ sender: UIBarButtonItem) {
        contentTitle = "Current Weather in " + today["city"]! + ", " + today["state"]!
        contentDescription = today["summery"]! + ", " + today["temperature"]!
        contentURL = "http://forecast.io"
        contentURLImage = "http://cs-server.usc.edu:45678/hw/hw8/images/" + today["currenticon"]!
        let content: FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = URL(string: self.contentURL)
        content.contentTitle = self.contentTitle
        content.contentDescription = self.contentDescription
        content.imageURL = URL(string: self.contentURLImage)
        let dialog = FBSDKShareDialog()
        dialog.mode = FBSDKShareDialogMode.feedWeb
        dialog.shareContent = content
        dialog.delegate = self
        dialog.fromViewController = self
        dialog.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todaytitle.count + 1;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if((indexPath as NSIndexPath).row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "header")! as! TodayHeaderTableViewCell
            cell.icon.contentMode = .scaleAspectFill
            let weathericon = UIImage(named: self.today["currenticon"]!)
            cell.icon.image = resizeImage(weathericon!, newWidth:100)
            cell.summery.text = today["summery"]! + " in " + today["city"]! + ", " + today["state"]!
            cell.temperature.text = today["temperature"]
            cell.maxMin.text = "L: " + today["lowtemp"]! + " | H: " + today["maxtemp"]!
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = bgColorView
            cell.isUserInteractionEnabled = false
            return cell
        } else {
            let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "todayDetail")! as UITableViewCell
            cell.textLabel?.text = self.todaytitle[(indexPath as NSIndexPath).row-1]
            cell.detailTextLabel?.text = self.todaydetail[(indexPath as NSIndexPath).row-1]
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = bgColorView
            cell.isUserInteractionEnabled = false
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath as NSIndexPath).row == 0 {
            return 270
        } else {
            return 40
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
//        navigationController?.hidesBarsOnTap = false;
        print(today)
//        background.hidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail") {
            let svc = segue.destination as! DetailViewController
            svc.detail24Hours = detail24Hours
            svc.detail7days = detail7days
            svc.degree = degree
        }
        if (segue.identifier == "showMap") {
            let svc = segue.destination as! AerisMapViewController
            svc.lon = lon
            svc.lat = lat
        }
    }
    
    func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable: Any]) {
        if results["postId"] != nil {
            let alert = UIAlertController(
                title: "Facebook Response",
                message: "Customer post is complete!",
                preferredStyle: UIAlertControllerStyle.alert
            )
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(
                title: "Facebook Response",
                message: "Customer post is canceled!",
                preferredStyle: UIAlertControllerStyle.alert
            )
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
        let alert = UIAlertController(
            title: "Facebook Response",
            message: "Customer post is failed!",
            preferredStyle: UIAlertControllerStyle.alert
        )
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func sharerDidCancel(_ sharer: FBSDKSharing!) {
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
