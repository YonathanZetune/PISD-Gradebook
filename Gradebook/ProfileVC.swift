//
//  ProfileVC.swift
//  Gradebook
//
//  Created by Yonathan Zetune on 6/25/17.
//  Copyright © 2017 Yoni Zetune. All rights reserved.
//

import UIKit
import WebKit
import SJSegmentedScrollView
import FLAnimatedImage
import PINRemoteImage
import SwiftSoup
import Firebase
import MessageUI
class ProfileVC: UsernameVC, MFMailComposeViewControllerDelegate {

    @IBOutlet var profileView: UIView!

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var gpaLabel: UILabel!
     var mystudents: [Student]!
    var nameContactTXTField = UITextField()
    var clickedNoThx = false
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
 
     func emailPrompt() -> Void {
        self.ref = Database.database().reference()
        let conditionRef = self.ref?.child("condition")
        self.databaseHandle = conditionRef?.observe(.value, with: { (snapshot) in
            let post = snapshot.value as? Bool
            if (post == true && self.clickedNoThx == false) {
        print("email pressed")
            
            let alert = UIAlertController(title: "Gradebook Shutdown", message: "Gradebook is in danger of shutting down starting this summer if we don’t get new access to simple online gradebook permissions from Pinnacle. We need your help to tell PISD and Pinnacle how important this app is!"
, preferredStyle: .actionSheet)
            
            
            alert.addAction(UIAlertAction(title: "No Thanks", style: .cancel, handler: { (action) in
                self.clickedNoThx = true
            }))
            alert.addAction(UIAlertAction(title: "Read More", style: .default, handler: { (action) in
                let alert2 = UIAlertController(title: "What's Happening?", message: "Pinnacle changes their web structure frequently, making maintenance of the app difficult. If they provide a special server access (an API) to the app, at no cost to them, the app can continue to function without this maintenance."
                    , preferredStyle: .actionSheet)
                
                alert2.addAction(UIAlertAction(title: "Next", style: .default, handler: { (action) in
                    let alert3 = UIAlertController(title: "What's Happening?", message: "Gradebook will be shutting down in the coming weeks/months if Pinnacle doesn’t provide this API."
                        , preferredStyle: .actionSheet)
                    
                    
                    alert3.addAction(UIAlertAction(title: "Next", style: .default, handler: { (action) in
                        let alert4 = UIAlertController(title: "What's Happening?", message: "Let PISD and Pinnacle (Wazzle Inc.) know you care for the app by emailing Pinnacle and PISD administrators to make this easy change. "
                            , preferredStyle: .actionSheet)
                        alert4.addAction(UIAlertAction(title: "Maybe Later", style: .cancel, handler: { (action) in
                            self.clickedNoThx = true
                        }))
                        alert4.addAction(UIAlertAction(title: "I'm in!", style: .default, handler: { (action) in
                            let alertForm = UIAlertController(title: "Name", message: "Please type your name below" , preferredStyle: .alert)
                            alertForm.addTextField(configurationHandler: nil)
                            alertForm.addAction(UIAlertAction(title: "Next", style: .default, handler: { (action) in
                            self.nameContactTXTField = alertForm.textFields![0]
                             self.clickedNoThx = true
                            if MFMailComposeViewController.canSendMail(){
                                let mailComposevViewController = self.configureMailController(myField: self.nameContactTXTField)
                                self.present(mailComposevViewController, animated: true, completion: nil)
                            }
                            else {
                                self.showMailError()
                            }
                                }))
                            self.present(alertForm, animated: true, completion: nil)
                        }))
                        self.present(alert4, animated: true, completion: nil)
                    }))
                    self.present(alert3, animated: true, completion: nil)
                }))
                self.present(alert2, animated: true, completion: nil)
            }))
        self.present(alert, animated: true, completion: nil)
            }})
    }
    override func viewDidAppear(_ animated: Bool) {
         emailPrompt()
    }
    
    override func viewDidLoad() {
        //super.viewDidLoad()
       
      // emailButtonLabel.alpha = 3
        print(self.view.isUserInteractionEnabled)
        let parenIndex = mystudents[0].studentInfo.index(of: "(")
        let stuName = mystudents[0].studentInfo.substring(to: parenIndex!)
        let stuID = mystudents[0].studentInfo.substring(from: parenIndex!)
        nameLabel.text = stuName
        idLabel.text = stuID
        
        print("PROFILE GPA: \(mystudents[mystudents.count-1].gpa)")
        gpaLabel.text = mystudents[mystudents.count-1].gpa
        
        self.ref = Database.database().reference()
        let conditionRef = self.ref?.child("Atten")
//        self.databaseHandle = conditionRef?.observe(.value, with: { (snapshot) in
//        let post = snapshot.value as? String
//        //if let actualPost = post {
//        // print("POST: \(actualPost))")
//        //self.attentionTitle.text = actualPost}})
//        let descripRef = self.ref?.child("newDescrip")
//        self.databaseHandle = descripRef?.observe(.value, with: { (snapshot) in
//            let post = snapshot.value as? String
//           // if let actualPost = post {
//                //print("POST: \(actualPost))")
//              //  self.attenDescrip.text = actualPost}})
//
//    }
//            }
//            }
//        }
    }

    
   
    func configureMailController(myField: UITextField) -> MFMailComposeViewController {
        var mailComposerVC = MFMailComposeViewController()
         mailComposerVC.mailComposeDelegate = self
        self.ref = Database.database().reference()
        let conditionRef = self.ref?.child("Atten")
        self.databaseHandle = conditionRef?.observe(.value, with: { (snapshot) in
        let post = snapshot.value as? [String]
        if let actualPost = post {
        print("POST: \(actualPost))")
            mailComposerVC.setToRecipients(actualPost) //(["yonathan@zetune.com", "bob@smith.com"])
            }})
        let descripRef = self.ref?.child("newDescrip")
        self.databaseHandle = descripRef?.observe(.value, with: { (snapshot) in
            let post2 = snapshot.value as? [String]
        mailComposerVC.setBccRecipients(post2)
            })
        mailComposerVC.setSubject("Gradebook Application Request")
        mailComposerVC.setMessageBody("Dear Wazzle Solutions and Plano ISD,\n\tI’m a PISD student and as someone who cares about their grades, I enjoy the convenience of the Gradebook app on the App Store. It provides mobile access to my grades as they come in. However, the developer of the app, Yonathan Zetune, will not be able to maintain the engine that finds the grades online to display them in the app. Wazzle needs to provide APIs to access student grades so that the app can continue to function.\n\tPISD, please work with Wazzle to provide this information so that Gradebook can continue to serve the student community at large for the years to come. Contact information for the developer is listed below.\n\nSincerely,\n \(String(describing: myField.text!))\n\nDeveloper contact:\nEmail: yonathan+gradebook@zetune.com", isHTML: false)
            
        return mailComposerVC
        
    }
    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Could not create email", message: "Please set up your email account", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}


    
    extension ProfileVC: SJSegmentedViewControllerViewSource {
        
        func viewForSegmentControllerToObserveContentOffsetChange() -> UIView {
            
            return profileView
        }
        
}
