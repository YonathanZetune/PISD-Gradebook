


import UIKit
import SJSegmentedScrollView
import WebKit
import GoogleMobileAds
import Firebase

class NineWeeksTableViewController: HeaderViewController {
    
    
 @IBOutlet weak var nineWeekTable: UITableView!
    

    // var userWeb = WKWebView()
   //var mystudents: [Student]!
    var mystudents: [Student]!
    var weekWeb = WKWebView()
    var theAssigned: [Assignment]!
    var nineWeekBool = false
    @IBOutlet weak var nineWeeksLabel: UILabel!
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    
    
    override func viewDidLoad() {
        //self.navigationController?.setNeedsStatusBarAppearanceUpdate()
        //super.viewDidLoad()

      
        nineWeeksLabel.text = "3rd Nine Weeks"
        self.ref = Database.database().reference()
        let conditionRef = self.ref?.child("condition")
        self.databaseHandle = conditionRef?.observe(.value, with: { (snapshot) in
            let post = snapshot.value as? String
            if let actualPost = post {
                print("POST: \(actualPost))")
                self.nineWeeksLabel.text = actualPost
            }
        })
        print("NAME \(mystudents[1].title)")
        //nineWeekTable.register(UINib(nibName: "NineWeekCellTableViewCell", bundle: nil), forCellReuseIdentifier: "NineWeekCustomCell"
         weekWeb.frame = CGRect(x: 0, y: 300, width: 300, height: 300)
        //view.addSubview(weekWeb)
         self.nineWeekTable.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 50,right: 0)

    }
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .default
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let assignments = sender as AnyObject as? [Assignment],
          
            let sendMe = segue.destination as? ClassTableViewController
            else { return }
        
        sendMe.myAssignments = assignments

    }
   
//    override func viewDidAppear(_ animated: Bool) {
//
//    }
    
    @IBAction func changeWeeksPressed(_ sender: Any) {
        print("NineWeeksChange")
    nineWeekTable.reloadData()
//        if nineWeekBool == true{
//            nineWeeksLabel.text = "3rd Nine Weeks"
//            nineWeekBool = false
//        } else{
//            nineWeekBool = true
//            nineWeeksLabel.text = "1st Semester"
//        }
    }
    
    func loadWebClass(myurl: String){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
        let url = URL(string: myurl)!
        let request = URLRequest(url: url)
        //myheaderLabel = "TRY AGAIN"
        weekWeb.load(request)
        
    }
//    
//    func startParse(myHTML: String) throws {
//        let classResponse = try ClassParser(myHTML)
//        
//    }
    
   

    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
   
}
extension NineWeeksTableViewController: UITableViewDataSource, UITableViewDelegate  {
   
    
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (mystudents.count)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)// as! NineWeekCellTableViewCell
     // cell.detailTextLabel?.text = "1"
    
             //cell.periodLabel?.text = mystudents[indexPath.row].author
        //print(mystudents[indexPath.row].author)
    nineWeekTable.beginUpdates()
        cell.textLabel?.text = mystudents[indexPath.row].title
        if nineWeekBool == true {
        cell.detailTextLabel?.text = mystudents[indexPath.row].grade[indexPath.row]
        }
        else {
            cell.detailTextLabel?.text = mystudents[indexPath.row].grade2[indexPath.row]
        }
        let myInt1 = cell.detailTextLabel?.text?.index(of: "%")
        if(myInt1 != nil){
        let myInt = cell.detailTextLabel?.text?.substring(to: myInt1!)
        //print(myInt!)
        let trueInt = Int(myInt!)
        if(trueInt! >= 90){
            cell.detailTextLabel?.textColor = UIColor(red:0.30, green:0.77, blue:0.33, alpha:1.0)
        }
        if(trueInt! >= 80 && trueInt! < 90){
            cell.detailTextLabel?.textColor = UIColor.orange
        }
        if(trueInt! >= 70 && trueInt! < 80){
            cell.detailTextLabel?.textColor = UIColor.red
           
        }
        if(trueInt! < 70){
        cell.detailTextLabel?.textColor = UIColor.red
        cell.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 25.0)
        }
        
        }
       nineWeekTable.endUpdates()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.prepare()
            generator.impactOccurred()
            
            
             print("Selected \(indexPath.row)")
            nineWeekTable.beginUpdates()
            if nineWeekBool == true {
                 loadWebClass(myurl: "https://gradebook.pisd.edu/Pinnacle/Gradebook/InternetViewer/\(mystudents[indexPath.row].classView)")
            }
            else {
                 loadWebClass(myurl: "https://gradebook.pisd.edu/Pinnacle/Gradebook/InternetViewer/\(mystudents[indexPath.row].classView)")
            }
           
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.weekWeb.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML", completionHandler: { (innerHTML, error) in
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                do{
                    
                    let classResponse = try ClassParser(innerHTML)
//                    startParse(myHTML: "https://gradebook.pisd.edu/Pinnacle/Gradebook/InternetViewer/\(mystudents[indexPath.row].classView)")
                    print("THEN")
                 
                 self.performSegue(withIdentifier: "ShowClass", sender: classResponse.classAssignments)
                      
                    print("WHERE")
                    
                    
                } catch {}
                    })
            })
    })
     nineWeekTable.endUpdates()
    }
}



extension NineWeeksTableViewController: SJSegmentedViewControllerViewSource {
    
    func viewForSegmentControllerToObserveContentOffsetChange() -> UIView {
        
        return nineWeekTable
    }
 
   
}
