//
//  ViewController.swift
//  yourPISD
//
//  Created by Yonathan Zetune on 5/30/17.
//  Copyright © 2017 Yoni Zetune. All rights reserved.
//

import UIKit
import GoogleMobileAds
import SwiftSoup
import WebKit
import SwiftOverlays
import BEMCheckBox
import paper_onboarding
import  LocalAuthentication

class ViewController: UIViewController, GADBannerViewDelegate, BEMCheckBoxDelegate, UITextFieldDelegate {
    

    @IBOutlet weak var reportButton: UIButton!
    @IBAction func reportPressed(_ sender: Any) {
        if let url = NSURL(string:"https://www.facebook.com/gradebookapp/") {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
      
        }
       
    }
    
    @IBOutlet weak var myBanner: GADBannerView!
    
    @IBOutlet weak var gobuttom: UIButton!
    
    @IBOutlet weak var rememPassBox: BEMCheckBox!
   
    @IBOutlet weak var autoLoginBox: BEMCheckBox!
    
    @IBOutlet weak var passField: UITextField!
    
    let webView = WKWebView()
    var counter = 0
    var passrememberOn = false
    var autoCount = 0
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        let context: LAContext = LAContext()
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
//            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Scan to sign in", reply: { (wasSuccessful, error) in
//                if wasSuccessful { print("SUCCESS")
//
//                }
//                else{}})
//        }
        reportButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            if((self.autoLoginBox.on == true) && (self.autoCount == 0)){
                self.webScrape(change: 0)
                print("AUTO: \(self.autoCount)")
            }
        })
        rememPassBox.delegate = self
        autoLoginBox.delegate = self
        //rememPassBox.delegate = self
//        if (passrememberOn == true){
//            rememPassBox.on = true
//        }
        
       
        self.usernameField.delegate = self
        self.passField.delegate = self
        
        
        
        let usernameKey = UserDefaults.standard
        usernameField.text = usernameKey.string(forKey: "savedUsernameKey")
        
        let passKey = UserDefaults.standard
        passField.text = passKey.string(forKey: "savedPassKey")
        
        let passBox = UserDefaults.standard
        rememPassBox.on = passBox.bool(forKey: "boxon")
        
        let logBox = UserDefaults.standard
        autoLoginBox.on = logBox.bool(forKey: "boxon2")
        
        let url = URL(string: "https://gradebook.pisd.edu/pinnacle/gradebook/logon.aspx")!
        let request = URLRequest(url: url)
        webView.frame = CGRect(x: 0, y: 300, width: 300, height: 300)
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36"
        webView.load(request)
        //view.addSubview(webView)

        //Banner Request
////        
//        let banrequest = GADRequest()
//        //banrequest.testDevices = [kGADSimulatorID]
//        banrequest.testDevices = [kGADSimulatorID, "ca-app-pub-9485038401645013/5068313886"];
//        //setup ad
//        
//        myBanner.adUnitID = "ca-app-pub-9485038401645013/5068313886"
//       
//        myBanner.rootViewController = self
//        myBanner.delegate = self
//        myBanner.load(banrequest)

        // Do any additional setup after loading the view, typically from a nib.
        gobuttom.isEnabled = true

        
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func didTap(_ checkBox: BEMCheckBox) {
        var setpassBox = false
        var setLogBox = false
        var passText = ""
        let alert = UIAlertController(title: "Password Empty", message: "Please enter a password before selecting remember.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        print("user tapped \(checkBox.tag): \(checkBox.on)")
        if(checkBox.tag == 1 && checkBox.on == true){
            if(passField.text! == ""){
                self.present(alert, animated: true, completion: nil)
               rememPassBox.on = false
            } else {
             passText = passField.text!
            setpassBox = rememPassBox.on
            }
        }
        if(checkBox.tag == 1 && checkBox.on == false){
            setpassBox = rememPassBox.on
            autoLoginBox.on = false
            passField.text! = ""
        }
        if(checkBox.tag == 2 && checkBox.on == true){
            if(passField.text! == ""){
                self.present(alert, animated: true, completion: nil)
                rememPassBox.on = false
                autoLoginBox.on = false
            } else {
            passText = passField.text!
            // let setpassBox = rememPassBox.on
            setpassBox = rememPassBox.on
            setLogBox = autoLoginBox.on
            rememPassBox.on = true
            }
        }
        if(checkBox.tag == 2 && checkBox.on == false){
            //passText = ""//passField.text!
            // let setpassBox = rememPassBox.on
            setpassBox = false
            
        }
       
     UserDefaults.standard.set(passText, forKey: "savedPassKey")
     UserDefaults.standard.set(setpassBox, forKey: "boxon")
     UserDefaults.standard.set(setLogBox, forKey: "boxon2")
    }

    public func increaseCount(num: Int) {
        self.counter += num
    }
    
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBAction func usernameChanged(_ sender: Any) {
        print("textfield : \(String(describing: usernameField.text))")
        
        gobuttom.isEnabled = true
    }
    
    func myFunction() {
    webView.evaluateJavaScript("document.getElementById('form1').submit()", completionHandler: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameField.resignFirstResponder()
        passField.resignFirstResponder()
        return (true)
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
//        guard let students = sender as AnyObject as? [Student]
//        else { return }
//        let sendMe = segue.destination as? UsernameVC
//        //guard let terms = sender as AnyObject as? [TermReport]
//            //else { return }
//
//        sendMe?.students = students
//        sendMe?.userWebView = webView
//       // sendMe?.terms = terms
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // guard let students = sender as AnyObject as? [Student]
        //else { return }
        guard let segueData = sender as AnyObject as? TermData
        else { return }
        if let secondVC = segue.destination as? UsernameVC {
            secondVC.students = segueData.students
            secondVC.userWebView = webView
            secondVC.terms = segueData.termReports
        }

        
    }
    
    func webScrape(change: Int) {
        counter += change
        switch counter {
        case 0:
              let overlaytext = "Signing in..."
              self.showWaitOverlayWithText(overlaytext)
           DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
          
            //self.showWaitOverlayWithText(overlaytext)
           
            
            self.webView.evaluateJavaScript("document.getElementById('ContentPlaceHolder_Password').value='\(self.passField.text!)'", completionHandler: nil)
            self.webView.evaluateJavaScript("document.getElementById('ContentPlaceHolder_Username').value='\(self.usernameField.text!.lowercased())'", completionHandler: nil)
            
            self.webView.evaluateJavaScript("document.getElementById('ContentPlaceHolder_LogonButton').click()", completionHandler: nil)
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {

//            })
            print("times up")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                // Put your code which should be executed with a delay here
                print("prt2")
                
                self.webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML", completionHandler: { (innerHTML, error) in
                    do{
                        
                        let gradeResponse = try Parser(innerHTML)
                        let termData = TermData(students: gradeResponse.students, termReports: gradeResponse.termReports)
                        //if grader
                        self.removeAllOverlays()
                        if (gradeResponse.goodCredentials == 1){
                            print("need to add message")
                            let alert = UIAlertController(title: "Invalid Credentials", message: "Please enter a valid username and password.\nExample: \n Username: firstname.lastname.1\nPassword: mypassword", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        else if (gradeResponse.goodCredentials == 2){
                            print("need to add message")
                            let alert = UIAlertController(title: "Server Error", message: "The Gradebook server is currently down or scheduled for maintenance. Please try again later.", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                            
                        else {
                            
                           // termData.students = gradeResponse.students
                          //  termData.termReports = gradeResponse.termReports
                            self.performSegue(withIdentifier: "ShowStudents", sender: termData)
//                            self.performSegue(withIdentifier: "ShowStudents", sender: gradeResponse.students)
//                            self.performSegue(withIdentifier: "ShowStudents2", sender: gradeResponse.termReports)
   
                        }
                    }catch {}
                })
                
                
                
            })
             })
        case 1:
           
            print("Showing class data")
            
            
            //     webView.evaluateJavaScript("document.getElementById('form1').submit();", completionHandler: nil)
            
            webView.evaluateJavaScript("document.getElementByName('period').click()", completionHandler: nil)
            
            
        default:
            webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML", completionHandler: { (innerHTML, error) in
                do{
                    
                    let gradeResponse = try Parser(innerHTML)
                    self.performSegue(withIdentifier: "ShowStudents", sender: gradeResponse.students)
                    
                }catch {}
            })
            
            
        }
        //counter += 1
        
    }
    
    @IBAction func goPressed(_ sender: Any) {

        let userText = usernameField.text
        UserDefaults.standard.set(userText, forKey: "savedUsernameKey")
        passrememberOn = true
        UserDefaults.standard.synchronize()
    webScrape(change: 0)


        if(usernameField.text != "" && passField.text != ""){
            print(passField.text)
            print("OK")
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
   
    
}
