//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by User on 8/26/16.
//  Copyright © 2016 User. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AFNetworking
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class SearchViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {

    @IBOutlet weak var StreetInput: UITextField!
    @IBOutlet weak var CityInput: UITextField!
//    @IBOutlet weak var StreetInput: UITextField!
    var street = String();
//    @IBOutlet weak var background: UIImageView!
    var city = String();
    var state = String();
    var activityIndicator = UIActivityIndicatorView()
    var todayData : [String:String] = [:]
    var lon = Double(0)
    var lat = Double(0)
//    @IBOutlet weak var CityInput: UITextField!
    var degree = String();
    var colors = ["Red","Yellow","Green","Blue"]
    var stateIndex = ["Please Select State", "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    var stateData : [String : String] = ["Please Select State" : "", "Alabama" : "AL", "Alaska" : "AK", "Arizona" : "AZ", "Arkansas" : "AR", "California" : "CA", "Colorado" : "CO" , "Connecticut" : "CT", "Delaware" : "DE", "Florida" : "FL", "Georgia" : "GA", "Hawaii" : "HA", "Idaho" : "ID", "Illinois" : "IL", "Indiana" : "IN", "Iowa" : "IA", "Kansas" : "KS", "Kentucky" : "KY", "Louisiana" : "LA", "Maine" : "ME", "Maryland" : "MD", "Massachusetts" : "MA", "Michigan" : "MI", "Minnesota": "MN", "Mississippi":"MS", "Missouri":"MO", "Montana":"MT", "Nebraska":"NE", "Nevada":"NV", "New Hampshire":"NH", "New Jersey":"NJ", "New Mexico":"NM", "New York":"NY", "North Carolina":"NC", "North Dakota":"ND", "Ohio":"OH", "Oklahoma":"OK", "Oregon":"OR", "Pennsylvania":"PA", "Rhode Island":"RI", "South Carolina":"SC", "South Dakota":"SD", "Tennessee":"TN", "Texas":"TX", "Utah":"UT", "Vermont":"VT", "Virginia":"VA", "Washington":"WA", "West Virginia":"WV", "Wisconsin":"WI", "Wyoming":"WY"]
    var detail24Hours : [Next24Hours] = []
    var detail7days : [Next7Days] = []
    @IBOutlet weak var stateInput: UIPickerView!
    @IBOutlet weak var degreeSet: UISwitch!
    @IBOutlet weak var background: UIImageView!
    
    @IBAction func focastIO(_ sender: UIButton) {
        if let url = URL(string: "http://forecast.io") {
                UIApplication.shared.openURL(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.StreetInput.delegate = self
        self.CityInput.delegate = self
        self.stateInput.delegate = self
        let blurredImage = UIImage(named: "Photo Dec 06, 11 30 24.jpg")!.applyBlurWithRadius(
            CGFloat(10),
            tintColor: nil,
            saturationDeltaFactor: 1.0,
            maskImage: nil
        )
        background.image = blurredImage
        self.navigationController?.navigationBar.tintColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func numberOfComponentsInPickerView(_ pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stateIndex.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return stateIndex[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = stateIndex[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-light", size: 22.0)!,NSForegroundColorAttributeName:UIColor.black])
        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = .center
        return pickerLabel
    }

    @IBAction func submit(_ sender: AnyObject) {
        if (validation()) {
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
            activityIndicator.backgroundColor = UIColor.gray
            activityIndicator.layer.cornerRadius = 10
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            UrlRequest()
        }
    }
    
    @IBAction func clearIp(_ sender: UIButton) {
        StreetInput.text = "";
        CityInput.text = "";
        stateInput.selectRow(0, inComponent: 0, animated: true)
        degreeSet.setOn(true, animated: true)
    }

    
    func validation() -> Bool {
        var error = false;
        var messageContent = "Please enter your "
        if(StreetInput.text==""||StreetInput.text!.trimmingCharacters(in: CharacterSet.whitespaces)=="") {
            messageContent += "Street Address, "
            error = true;
        }
        if(CityInput.text==""||CityInput.text!.trimmingCharacters(in: CharacterSet.whitespaces)=="") {
            messageContent += "City, "
            error = true;
        }
        if(stateInput.selectedRow(inComponent: 0)==0) {
            messageContent += "State, "
            error = true;
        }
        if (error == true) {
            messageContent = messageContent.substring(with: (messageContent.startIndex ..< messageContent.characters.index(messageContent.endIndex, offsetBy: -2)))
            let alert = UIAlertController(
                title: "Information Required",
                message: messageContent,
                preferredStyle: UIAlertControllerStyle.alert
            )
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }

    
    func UrlRequest() {
        if (degreeSet.isOn) {
            degree = "Fahrenheit"
        } else {
            degree = "Celsius"
        }
        state = stateIndex[stateInput.selectedRow(inComponent: 0)]
        let awsurl = "http://csci571mingjiej-env.elasticbeanstalk.com"
        let parameters: [String:String] = ["street": StreetInput.text!, "city" : CityInput.text!, "state" : state, "degree": degree]
        Alamofire.request(awsurl, method: .get, parameters: parameters)
            .responseJSON { response in
                let swiftjsondata = JSON(response.result.value!)
                print("JSON: \(swiftjsondata)")
                self.handleData(swiftjsondata)
                
        }
    }

    func handleData(_ data: JSON) {
        detail24Hours.removeAll()
        detail7days.removeAll()
        //lat = Double(String(describing: data["latitude"]))!
        lat = data["latitude"].doubleValue
        lon = data["longitude"].doubleValue
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
        
        let currenticon = chooseIcon(data["currently"]["icon"].stringValue);
        var precipitation = "";
        let precipIntensityFloat = data["currently"]["precipIntensity"].floatValue
        if( precipIntensityFloat < 0.002) {
            precipitation += "None";
        } else if(precipIntensityFloat < 0.017) {
            precipitation += "Very Light";
        } else  if(precipIntensityFloat < 0.1) {
            precipitation += "Light";
        } else  if(precipIntensityFloat < 0.4) {
            precipitation += "Moderate";
        } else {
            precipitation += "Heavy";
        }
        let timeZone = data["timezone"].stringValue
        let currentFormatter = DateFormatter()
        currentFormatter.dateFormat = "h:mm a"
        currentFormatter.timeZone = TimeZone(identifier: timeZone)
        let temperature = String(describing: data["currently"]["temperature"].intValue) + "\u{00B0}" + degree
        let windspeed = String(data["currently"]["windSpeed"].intValue) + " " + windSpeedunit
        let humidity = String(data["currently"]["humidity"].intValue * 100) + "%"
        let summery = data["currently"]["summary"].stringValue
        let precipProbability = String(data["currently"]["precipProbability"].intValue * 100) + "%"
        let dewPoint = String(data["currently"]["dewPoint"].intValue) + "\u{00B0}" + degree
        let visibility = String(data["currently"]["visibility"].intValue) + " " + visibilityunit
        let sunrise = currentFormatter.string(from: Date(timeIntervalSince1970: data["daily"]["data"][0]["sunriseTime"].doubleValue))
        let sunset = currentFormatter.string(from: Date(timeIntervalSince1970: data["daily"]["data"][0]["sunsetTime"].doubleValue))
        
        let lowInt = data["daily"]["data"][0]["temperatureMin"].intValue
        let maxInt = data["daily"]["data"][0]["temperatureMax"].intValue
        let lowtemp = String(lowInt) + "\u{00B0}" + degree
        let maxtemp = String(maxInt) + "\u{00B0}" + degree
        todayData = ["currenticon":currenticon, "temperature":temperature, "windspeed":windspeed,"humidity":humidity, "summery":summery, "precipProbability":precipProbability, "precipitation":precipitation, "dewPoint":dewPoint, "visibility":visibility, "sunrise":sunrise, "sunset":sunset, "lowtemp":lowtemp, "maxtemp":maxtemp, "city":CityInput.text!, "state":stateData[state]!]
        //more detail data handeling
        
        for i in 1...48 {
            let pic = chooseIcon(data["hourly"]["data"][i]["icon"].stringValue)
            let timing = data["hourly"]["data"][i]["time"].stringValue
            let temperature = String(data["hourly"]["data"][i]["temperature"].intValue) + "\u{00B0}" + degree
            let hourObject = Next24Hours(pic: pic, timing: convertTime(timing, pattern: "hh:mm a", timezone: timeZone), temperature: temperature)
            detail24Hours.append(hourObject)
        }
        for i in 1...7 {
            let pic = chooseIcon(data["daily"]["data"][i]["icon"].stringValue)
            let timing = data["daily"]["data"][i]["time"].stringValue
            let mintemperature = String(data["daily"]["data"][i]["temperatureMin"].intValue) + "\u{00B0}" + degree
            let maxtemperature = String(data["daily"]["data"][i]["temperatureMax"].intValue) + "\u{00B0}" + degree
            let dailyObject = Next7Days(pic: pic, timing: convertTime(timing, pattern: "cccc, MMM d", timezone: timeZone), mintemperature: mintemperature, maxtemperature: maxtemperature)
            detail7days.append(dailyObject)
        }
        //make segue
        self.activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        performSegue(withIdentifier: "displayResult", sender: nil)
    }

    func chooseIcon(_ summary: String) -> String {
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
    
    func convertTime(_ timing: String, pattern: String, timezone: String) -> String {
        let UNIXtime = Double(timing)
        let date = Date(timeIntervalSince1970:UNIXtime!)
        let formatter = DateFormatter();
        formatter.dateFormat = pattern;
        formatter.timeZone = TimeZone(identifier: timezone);
        return formatter.string(from: date);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "displayResult") {
            let svc = segue.destination as! ResultViewController
            svc.today = todayData
            svc.detail24Hours = detail24Hours
            svc.detail7days = detail7days
            svc.lon = lon
            svc.lat = lat
            svc.degree = degree
        }
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
