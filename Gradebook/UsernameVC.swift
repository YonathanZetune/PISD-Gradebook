//
//  UsernameVC.swift
//  Gradebook
//
//  Created by Yonathan Zetune on 6/18/17.
//  Copyright © 2017 Yoni Zetune. All rights reserved.
//

import UIKit
import WebKit
import SwiftSoup
import SJSegmentedScrollView
import GoogleMobileAds
class UsernameVC: SJSegmentedViewController, GADBannerViewDelegate {//UIViewController {

    //@IBOutlet weak var studentInfoLabel: UILabel!

    @IBOutlet weak var myBanner: GADBannerView!
    

    var userWebView = WKWebView()
  
    var students: [Student]!
    var coolAssigns: [Assignment]!
  var selectedSegment: SJSegmentTab?
    var terms: [TermReport]!


    override func viewDidLoad() {
      
       // print("TERM \(terms[0].grades[3])")
        self.view.backgroundColor = UIColor(red:0.21, green:0.62, blue:1.00, alpha:1.0)
                if let storyboard = self.storyboard {
          
            let headerController = storyboard
                .instantiateViewController(withIdentifier: "HeaderViewController1") as! HeaderViewController
            //headerController.mystudents = students
        
            let firstViewController = storyboard
                .instantiateViewController(withIdentifier: "NineWeeksViewController") as! NineWeeksTableViewController
            firstViewController.title = "Nine Weeks"//students[0].terms[students[0].maxTerms-2]
                      firstViewController.mystudents = students
            firstViewController.weekWeb = userWebView
           firstViewController.theAssigned = coolAssigns
                    
//                    let fifthController = storyboard
//                    .instantiateViewController(withIdentifier: "ClassVC") as! ClassTableViewController
//                fifthController.myAssignments = coolAssigns
            let secondViewController = storyboard
                .instantiateViewController(withIdentifier: "SemesterTVC") as! SemesterTVC
      secondViewController.title = "Semester"
    secondViewController.mystudents = students
    secondViewController.myWebView = userWebView
    secondViewController.myterms = terms
                    let profileViewController = storyboard
                        .instantiateViewController(withIdentifier: "profileView") as! ProfileVC
                    profileViewController.title = "Profile"
           profileViewController.mystudents = students
//                profileViewController.view.addConstraint(NSLayoutConstraint(item: profileViewController, attribute: .bottom, relatedBy: .equal, toItem: profileViewController.bottomLayoutGuide, attribute:.top, multiplier: 1, constant: 50))
                    
                    let classViewController = storyboard
                        .instantiateViewController(withIdentifier: "ClassVC") as! ClassTableViewController
                    classViewController.title = "ClassView"
                    classViewController.myAssignments = coolAssigns
//                    classViewController.classStuds = students
//
            
            headerViewController = headerController
            segmentControllers = [profileViewController,firstViewController,
                                  secondViewController]
                  
            headerViewHeight = 130
            selectedSegmentViewHeight = 5.0
            segmentTitleColor = .gray
            selectedSegmentViewColor = UIColor(red:0.21, green:0.62, blue:1.00, alpha:1.0)
            segmentShadow = SJShadow.medium()
            showsHorizontalScrollIndicator = true
            showsVerticalScrollIndicator = true
            
            delegate = self
            
        }
        
        title = "Segment"
        
      
        super.viewDidLoad()
        //addChildViewController(headerViewController!)
    }
   
    

//
//    @IBAction func signoutClicked(_ sender: UIButton) 
//   
//    func setmystud( changeme: [Student]) {
//        var mechangeme = changeme
//        mechangeme = students
//    }
//    func loadClass(myurl: String){
//        let url = URL(string: myurl)!
//        let request = URLRequest(url: url)
//        userWebView.load(request)
//    }

   

}

extension UsernameVC: SJSegmentedViewControllerDelegate {
   
    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {
        segmentBackgroundColor =  UIColor(red:0.04, green:0.67, blue:0.98, alpha:1.0)
        
        if selectedSegment != nil {
            selectedSegment?.titleColor(.lightGray)
        }
        
        if segments.count > 0 {
            
            selectedSegment = segments[index]
            selectedSegment?.titleColor(.darkGray)
        }
        //segment?.addConstraint(NSLayoutConstraint.)
    }
}
