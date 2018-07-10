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
class ClassControlVC: SJSegmentedViewController {
    
    
//    var userWebView = WKWebView()
//    
//    var students: [Student]!
//    var coolAssigns: [Assignment]!
    var selectedSegment: SJSegmentTab?
    var controlAss: [Assignment]!
    var controlStudents: [Student]!
    override func viewDidLoad() {
        
        //print(students[0].author)
        if let storyboard = self.storyboard {
            
            let headerController = storyboard
                .instantiateViewController(withIdentifier: "ClassHeader") as! ClassHeaderVC
            //headerController.mystudents = students
            
//           
            let firstViewController = storyboard
                .instantiateViewController(withIdentifier: "ClassVC") as! ClassTableViewController
            firstViewController.title = "ClassView"
            firstViewController.myAssignments = controlAss
           // firstViewController.classStuds = controlStudents
            
            headerViewController = headerController
         //   segmentControllers = [firstViewController]
            headerViewHeight = 60
            selectedSegmentViewHeight = 5.0
            segmentTitleColor = .gray
            selectedSegmentViewColor = UIColor.clear//(red:0.21, green:0.62, blue:1.00, alpha:1.0)
            segmentShadow = SJShadow.medium()
            showsHorizontalScrollIndicator = true
            showsVerticalScrollIndicator = true
            
            delegate = self
            
        }
        
        title = "Segment2"
        super.viewDidLoad()
    }
    
    
 
}

extension ClassControlVC: SJSegmentedViewControllerDelegate {
    
    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {
        segmentBackgroundColor =  UIColor(red:0.04, green:0.67, blue:0.98, alpha:1.0)
        if selectedSegment != nil {
            selectedSegment?.titleColor(.lightGray)
        }
        
        if segments.count > 0 {
            
            selectedSegment = segments[index]
            selectedSegment?.titleColor(.darkGray)
        }
    }
}
