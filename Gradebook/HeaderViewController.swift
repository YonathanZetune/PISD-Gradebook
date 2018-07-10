//
//  HeaderViewController.swift
//  SJSegmentedScrollView
//
//  Created by Subins Jose on 13/06/16.
//  Copyright © 2016 Subins Jose. All rights reserved.
//

import UIKit
import WebKit
import SwiftSoup
import SJSegmentedScrollView
import GoogleMobileAds
class HeaderViewController: UIViewController, GADBannerViewDelegate {

    @IBOutlet weak var headerLabel: UILabel!
   // var headAssignments: [Assignment]!
    
    @IBOutlet weak var myBanner: GADBannerView!
    @IBAction func signOutButtonPressed(_ sender: Any) {
        logout()
        print("sign button")
        // self.performSegue(withIdentifier: "signOut", sender: (Any).self)
        
    }
    //var userWebView = WKWebView()
    var myheaderLabel = "yourPISD"
    //var mystudents: [Student]!
    func logout() {
       
        self.performSegue(withIdentifier: "signOut", sender: self)
    }
    
    override public func viewDidLoad() {
        let banrequest = GADRequest()
        //banrequest.testDevices = [kGADSimulatorID]
        banrequest.testDevices = [kGADSimulatorID, "ca-app-pub-9485038401645013/5068313886"];
        //setup ad
        
        myBanner.adUnitID = "ca-app-pub-9485038401645013/5068313886"
        
        myBanner.rootViewController = self
        myBanner.delegate = self
        myBanner.load(banrequest)

       // super.viewDidLoad()
       // print("HEAD \(headAssignments.count)")
        self.view.backgroundColor = UIColor(red:0.21, green:0.62, blue:1.00, alpha:1.0)
//          NotificationCenter.default.addObserver(self, selector: #selector(refreshLbl), name: NSNotification.Name(rawValue: "refresh"), object: nil)
               // studentInfoLabel.text = mystudents[0].studentInfo
        // Do any additional setup after loading the view.
    }
//
    
//    func refreshLbl() {
//        print("Received Notification")
//        headerLabel.text = myheaderLabel
//    }
 
}
