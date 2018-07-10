//
//  ClassHeaderVC.swift
//  Gradebook
//
//  Created by Yonathan Zetune on 6/27/17.
//  Copyright © 2017 Yoni Zetune. All rights reserved.
//

import UIKit
import WebKit
import SwiftSoup
import SJSegmentedScrollView
class ClassHeaderVC: UIViewController {
    
//
//    @IBAction func backButtonPressed(_ sender: Any) {
//        
//         //self.performSegue(withIdentifier: "backButton", sender: self)
//    }
    
//    @IBAction func signOutButtonPressed(_ sender: Any) {
//        logout()
//        print("sign button")
//        // self.performSegue(withIdentifier: "signOut", sender: (Any).self)
//        
//    }
    //var userWebView = WKWebView()
//    var myheaderLabel = "yourPISD"
//    //var mystudents: [Student]!
//    func logout() {
//        self.performSegue(withIdentifier: "signOut", sender: self)
//    }
    
    override public func viewDidLoad() {
        // super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.21, green:0.62, blue:1.00, alpha:1.0)//UIColor.clear//(red:0.21, green:0.62, blue:1.00, alpha:1.0)
        

        // studentInfoLabel.text = mystudents[0].studentInfo
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        guard let assigns = sender as AnyObject as? [Student],
            
            let sendMe = segue.destination as? NineWeeksTableViewController
            else { return }
        
        sendMe.mystudents = assigns
        //sendMe.userWebView = userWebView
    }
    
}
