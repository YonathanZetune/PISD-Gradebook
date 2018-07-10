//
//  SetupVCViewController.swift
//  Gradebook
//
//  Created by Yonathan Zetune on 8/27/17.
//  Copyright © 2017 Yoni Zetune. All rights reserved.
//

import UIKit
import paper_onboarding
class SetupVCViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {

    let uagree =  "Clicking Agree constitutes your agreement to the following conditions:This app will:send and receive data through Wi-Fi and your service provider.Communicate on your behalf with the server at gradebook.pisd.edu on an SSL-encrypted connection.Locally store your username and password on your mobile device (if you choose to Remember my password or Auto-login).This app will not:store personal information, including but not limited to your name, student ID, or academic records, locally or on any remote server (except as mentioned above).You (the user) will not:use this app to access a PISD account that is not yours.We (the developers) will not be responsible for:Damage incurred on your mobile device.Presentation of inaccurate information, including but not limited to name, student ID, or academic records."
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2 {
//            let actionSheet = UIAlertController(title: "User Agreement", message: uagree, preferredStyle: .actionSheet)
//            actionSheet.addAction(UIAlertAction(title: "Decline", style: .cancel, handler: nil))
//            actionSheet.addAction(UIAlertAction(title: "Accept", style: .default, handler: nil))
            UIView.animate(withDuration: 0.4, animations: {self.getStartedButton.alpha=1})
        }
    }
    

    
 
    

    @IBOutlet weak var onboardingView: OnboardingView!
    
    @IBOutlet weak var getStartedButton: UIButton!
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
         self.onboardingView.dataSource = self
        self.onboardingView.delegate = self
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    @IBAction func gotStarted(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "onboardingComplete")
        userDefaults.synchronize()
        
        //self.performSegue(withIdentifier: "intro", sender: nil)
    }
    override  func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func onboardingItemsCount() -> Int {
        return 3
    }
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        let backgroundColorOne = UIColor(red: 217/255, green: 72/255, blue: 89/255, alpha: 1)
        let backgroundColorTwo = UIColor(red: 106/255, green: 166/255, blue: 211/255, alpha: 1)
        let backgroundColorThree = UIColor(red: 168/255, green: 200/255, blue: 78/255, alpha: 1)
        
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        let descriptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
        let descriptionFont2 = UIFont(name: "AvenirNext-Regular", size: 12)!
        return [("brush", "Elegant UI", "Grades are organized and easy to access.", "", backgroundColorOne, UIColor.white, UIColor.white, titleFont, descriptionFont),
                ("Exam", "Assignment Tracking", "Individual assignments are prepsented with weights, due dates, and more.", "", backgroundColorTwo, UIColor.white, UIColor.white, titleFont, descriptionFont),
                ("Agreement", "User Agreement", uagree, "", backgroundColorThree, UIColor.white, UIColor.white, titleFont, descriptionFont2)][index]
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
    }
    func onboardingWillTransitonToIndex(_ index: Int) {
        
        if index == 1 {
            if self.getStartedButton.alpha == 1{
                UIView.animate(withDuration: 0.2, animations: {self.getStartedButton.alpha=0})
                
            }
        }
      
 
    
     
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    }
}
