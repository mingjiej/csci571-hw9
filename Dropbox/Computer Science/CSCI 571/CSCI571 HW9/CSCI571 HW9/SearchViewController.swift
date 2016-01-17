//
//  ViewController.swift
//  CSCI571 HW9
//
//  Created by User on 11/12/15.
//  Copyright © 2015 User. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController, UITextFieldDelegate {
//    var StreetInput: UITextField!
    @IBOutlet weak var StreetInput: UITextField!
    var street = String();
    @IBOutlet weak var background: UIImageView!
    var city = String();
    var state = String();
    var activityIndicator = UIActivityIndicatorView()
    var todayData : [String:String] = [:]
    var lon = Double(0)
    var lat = Double(0)
//    var detailData : [String:String] = [:]
//    @IBOutlet weak var CityInput: UITextField!
    @IBOutlet weak var CityInput: UITextField!
    var degree = String();
    var colors = ["Red","Yellow","Green","Blue"]
    var stateIndex = ["Please Select State", "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    var stateData : [String : String] = ["Please Select State" : "", "Alabama" : "AL", "Alaska" : "AK", "Arizona" : "AZ", "Arkansas" : "AR", "California" : "CA", "Colorado" : "CO" , "Connecticut" : "CT", "Delaware" : "DE", "Florida" : "FL", "Georgia" : "GA", "Hawaii" : "HA", "Idaho" : "ID", "Illinois" : "IL", "Indiana" : "IN", "Iowa" : "IA", "Kansas" : "KS", "Kentucky" : "KY", "Louisiana" : "LA", "Maine" : "ME", "Maryland" : "MD", "Massachusetts" : "MA", "Michigan" : "MI", "Minnesota": "MN", "Mississippi":"MS", "Missouri":"MO", "Montana":"MT", "Nebraska":"NE", "Nevada":"NV", "New Hampshire":"NH", "New Jersey":"NJ", "New Mexico":"NM", "New York":"NY", "North Carolina":"NC", "North Dakota":"ND", "Ohio":"OH", "Oklahoma":"OK", "Oregon":"OR", "Pennsylvania":"PA", "Rhode Island":"RI", "South Carolina":"SC", "South Dakota":"SD", "Tennessee":"TN", "Texas":"TX", "Utah":"UT", "Vermont":"VT", "Virginia":"VA", "Washington":"WA", "West Virginia":"WV", "Wisconsin":"WI", "Wyoming":"WY"]
    var detail24Hours : [Next24Hours] = []
    var detail7days : [Next7Days] = []
    
    @IBOutlet weak var stateInput: UIPickerView!
    @IBOutlet weak var degreeSet: UISwitch!
    @IBAction func forecastIO(sender: UIButton) {
        if let url = NSURL(string: "http://forecast.io") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnTap = true
        self.StreetInput.delegate = self
        self.CityInput.delegate = self
        let blurredImage = UIImage(named: "Photo Dec 06, 11 30 24.jpg")!.applyBlurWithRadius(
            CGFloat(10),
            tintColor: nil,
            saturationDeltaFactor: 1.0,
            maskImage: nil
        )
        background.image = blurredImage
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
        navigationController?.hidesBarsOnTap = false;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stateIndex.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return stateIndex[row]
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = stateIndex[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-light", size: 22.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = .Center
        return pickerLabel
    }
    
    @IBAction func submit(sender: AnyObject) {
        if (validation()) {
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 70, 70))
            activityIndicator.backgroundColor = UIColor.grayColor()
            activityIndicator.layer.cornerRadius = 10
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            UrlRequest()
        }
    }
    @IBAction func clearIp(sender: UIButton) {
        StreetInput.text = "";
        CityInput.text = "";
        stateInput.selectRow(0, inComponent: 0, animated: true)
        degreeSet.setOn(true, animated: true)
    }
    func validation() -> Bool {
        var error = false;
        var messageContent = "Please enter your "
        if(StreetInput.text==""||StreetInput.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())=="") {
            messageContent += "Street Address, "
            error = true;
        }
        if(CityInput.text==""||CityInput.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())=="") {
            messageContent += "City, "
            error = true;
        }
        if(stateInput.selectedRowInComponent(0)==0) {
            messageContent += "State, "
            error = true;
        }
        if (error == true) {
            messageContent = messageContent.substringWithRange(Range<String.Index>(start: messageContent.startIndex, end: messageContent.endIndex.advancedBy(-2)))
            let alert = UIAlertController(
                title: "Information Required",
                message: messageContent,
                preferredStyle: UIAlertControllerStyle.Alert
            )
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }
    func UrlRequest() {
        if (degreeSet.on) {
            degree = "Fahrenheit"
        } else {
            degree = "Celsius"
        }
        state = stateIndex[stateInput.selectedRowInComponent(0)]
        let awsurl = "http://csci571mingjiej-env.elasticbeanstalk.com"
        let parameters: [String:String] = ["street": StreetInput.text!, "city" : CityInput.text!, "state" : state, "degree": degree]
        Alamofire.request(.GET, awsurl, parameters: parameters)
            .responseJSON { response in
                let swiftjsondata = JSON(response.result.value!)
                print("JSON: \(swiftjsondata)")
                self.handleData(swiftjsondata)
                
        }
    }
    func handleData(data: JSON) {
        detail24Hours.removeAll()
        detail7days.removeAll()
        lat = Double(String(data["latitude"]))!
        lon = Double(String(data["longitude"]))!
        var windSpeedunit = ""
        var visibilityunit = ""
        var pressureunit = ""
        if(degree=="Fahrenheit") {
            windSpeedunit += "mph"
            visibilityunit += "mi"
            pressureunit += "mb"
            degree = "F"
        } else {
            windSpeedunit += "m/s"
            visibilityunit += "km"
            pressureunit += "hPa"
            degree = "C"
        }
        
        let currenticon = chooseIcon(String(data["currently"]["icon"]));
        var precipitation = "";
        if(Float(String(data["currently"]["precipIntensity"]))<0.002) {
            precipitation += "None";
        } else  if(Float(String(data["currently"]["precipIntensity"]))<0.017) {
            precipitation += "Very Light";
        } else  if(Float(String(data["currently"]["precipIntensity"]))<0.1) {
            precipitation += "Light";
        } else  if(Float(String(data["currently"]["precipIntensity"]))<0.4) {
            precipitation += "Moderate";
        } else {
            precipitation += "Heavy";
        }
        let timeZone = String(data["timezone"])
        let currentFormatter = NSDateFormatter()
        currentFormatter.dateFormat = "h:mm a"
        currentFormatter.timeZone = NSTimeZone(name: timeZone)
        let temperature = String(Int(Float(String(data["currently"]["temperature"]))!)) + "\u{00B0}" + degree
        let windspeed = String(Int(Float(String(data["currently"]["windSpeed"]))!)) + " " + windSpeedunit
        let humidity = String(Int(Float(String(data["currently"]["humidity"]))!*100)) + "%"
        let summery = String(data["currently"]["summary"])
        let precipProbability = String(Int(Float(String(data["currently"]["precipProbability"]))!*100)) + "%"
        let dewPoint = String(Int(Float(String(data["currently"]["dewPoint"]))!)) + "\u{00B0}" + degree
        let visibility = String(Int(Float(String(data["currently"]["visibility"]))!)) + " " + visibilityunit
        let sunrise = currentFormatter.stringFromDate(NSDate(timeIntervalSince1970: Double(String(data["daily"]["data"][0]["sunriseTime"]))!))
        let sunset = currentFormatter.stringFromDate(NSDate(timeIntervalSince1970: Double(String(data["daily"]["data"][0]["sunsetTime"]))!))
        let lowtemp = String(Int(Float(String(data["daily"]["data"][0]["temperatureMin"]))!)) + "\u{00B0}" + degree
        let maxtemp = String(Int(Float(String(data["daily"]["data"][0]["temperatureMax"]))!)) + "\u{00B0}" + degree
        todayData = ["currenticon":currenticon, "temperature":temperature, "windspeed":windspeed,"humidity":humidity, "summery":summery, "precipProbability":precipProbability, "precipitation":precipitation, "dewPoint":dewPoint, "visibility":visibility, "sunrise":sunrise, "sunset":sunset, "lowtemp":lowtemp, "maxtemp":maxtemp, "city":CityInput.text!, "state":stateData[state]!]
        //more detail data handeling
        
        for(var i = 0;i<49;i++) {
            let pic = chooseIcon(String(data["hourly"]["data"][i]["icon"]))
            let timing = String(data["hourly"]["data"][i]["time"])
            let temperature = String(Int(Float(String(data["hourly"]["data"][i]["temperature"]))!)) + "\u{00B0}" + degree
            let hourObject = Next24Hours(pic: pic, timing: convertTime(timing, pattern: "hh:mm a", timezone: timeZone), temperature: temperature)
            detail24Hours.append(hourObject)
        }
        for(var i = 1 ;i<=7;i++) {
            let pic = chooseIcon(String(data["daily"]["data"][i]["icon"]))
            let timing = String(data["daily"]["data"][i]["time"])
            let mintemperature = String(Int(Float(String(data["daily"]["data"][i]["temperatureMin"]))!)) + "\u{00B0}" + degree
            let maxtemperature = String(Int(Float(String(data["daily"]["data"][i]["temperatureMax"]))!)) + "\u{00B0}" + degree
            let dailyObject = Next7Days(pic: pic, timing: convertTime(timing, pattern: "cccc, MMM d", timezone: timeZone), mintemperature: mintemperature, maxtemperature: maxtemperature)
            detail7days.append(dailyObject)
        }
        //make segue
        self.activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        performSegueWithIdentifier("displayResult", sender: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "displayResult") {
            let svc = segue.destinationViewController as! ResultViewController
            svc.today = todayData
            svc.detail24Hours = detail24Hours
            svc.detail7days = detail7days
            svc.lon = lon
            svc.lat = lat
            svc.degree = degree
        }
    }
    func chooseIcon(summary: String) -> String {
        var currenticon = "";
        if(summary=="clear-day") {
            currenticon += "clear.png"
        } else if(summary=="clear-night") {
            currenticon += "clear_night.png"
        } else if(summary=="rain") {
            currenticon += "rain.png"
        } else if(summary=="snow") {
            currenticon += "snow.png"
        } else if(summary=="sleet") {
            currenticon += "hsleet.png"
        } else if(summary=="wind") {
            currenticon += "wind.png"
        } else if(summary=="fog") {
            currenticon += "fog.png"
        } else if(summary=="cloudy") {
            currenticon += "cloudy.png"
        } else if(summary=="partly-cloudy-day") {
            currenticon += "cloud_day.png"
        } else if(summary=="partly-cloudy-night") {
            currenticon += "cloud_night.png"
        }
        return currenticon
    }
    func convertTime(timing: String, pattern: String, timezone: String) -> String {
        let UNIXtime = Double(timing)
        let date = NSDate(timeIntervalSince1970:UNIXtime!)
        let formatter = NSDateFormatter();
        formatter.dateFormat = pattern;
        formatter.timeZone = NSTimeZone(name: timezone);
        return formatter.stringFromDate(date);
    }
}

