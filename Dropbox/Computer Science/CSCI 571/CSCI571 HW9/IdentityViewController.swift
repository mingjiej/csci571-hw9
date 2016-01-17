//
//  IdentityViewController.swift
//  CSCI571 HW9
//
//  Created by User on 11/14/15.
//  Copyright © 2015 User. All rights reserved.
//

import UIKit

class IdentityViewController: UIViewController {

    @IBOutlet weak var background: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        navigationController?.hidesBarsOnTap = false;
    }
    
    @IBAction func backToMain(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurredImage = UIImage(named: "USC_Bovard_Auditorium.png")!.applyBlurWithRadius(
            CGFloat(10),
            tintColor: nil,
            saturationDeltaFactor: 1.0,
            maskImage: nil
        )
        background.image = blurredImage
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = true
        // Do any additional setup after loading the view.
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
