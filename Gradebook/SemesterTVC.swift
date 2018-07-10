


import UIKit
import SJSegmentedScrollView
import WebKit
import  SwiftSoup

class SemesterTVC: HeaderViewController {
    
    
    @IBOutlet weak var nineWeekTable: UITableView!
    
    var numID = 0
    var myindex = Int(0)
    var calcAve = 0
    var mystudents: [Student]!
    var myterms: [TermReport]!
    var myWebView = WKWebView()
    var doc: Document!
    override func viewDidLoad() {
        
        nineWeekTable.register(UINib(nibName: "SemesterTableViewCell", bundle: nil), forCellReuseIdentifier: "SemesterCustomCell")
        // super.updateHeaderLabel("ClassView")
       
       // myWebView.frame = CGRect(x: 0, y: 300, width: 300, height: 300)
       // view.addSubview(myWebView)
        
       
    }
   
    
    func loadClass(myurl: String){
//       NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
        let url = URL(string: myurl)!
        let request = URLRequest(url: url)
        myWebView.load(request)
    }
    
    func getLevel(courseName: String) -> Double {
        var myReturn = 4.0
        if(courseName.contains(" AP") || courseName.contains("IB")) {
            myReturn = 5.0
            return myReturn
        }
        if(courseName.contains("PAP") || courseName.contains("IH") || courseName.contains(" H")) {
            myReturn = 4.5
        }
        return myReturn
    }
    func getTier(level: Double, grade: Int) -> Double {
        if (level == 4.0) {
            if(grade >= 97){return 4.0}
            if(grade >= 93){return 3.8}
            if(grade >= 90){return 3.6}
            if(grade >= 87){return 3.4}
            if(grade >= 83){return 3.2}
            if(grade >= 80){return 3.0}
            if(grade >= 77){return 2.8}
            if(grade >= 73){return 2.6}
            if(grade >= 71){return 2.4}
            if(grade >= 70){return 2.0}
            return 0.0
        }
        if (level == 4.5) {
            if(grade >= 97){return 4.5}
            if(grade >= 93){return 4.3}
            if(grade >= 90){return 4.1}
            if(grade >= 87){return 3.9}
            if(grade >= 83){return 3.7}
            if(grade >= 80){return 3.5}
            if(grade >= 77){return 3.3}
            if(grade >= 73){return 3.1}
            if(grade >= 71){return 2.9}
            if(grade >= 70){return 2.5}
            return 0.0
        }
        if (level == 5.0) {
            if(grade >= 97){return 5.0}
            if(grade >= 93){return 4.8}
            if(grade >= 90){return 4.6}
            if(grade >= 87){return 4.4}
            if(grade >= 83){return 4.2}
            if(grade >= 80){return 4.0}
            if(grade >= 77){return 3.8}
            if(grade >= 73){return 3.6}
            if(grade >= 71){return 3.4}
            if(grade >= 70){return 3.0}
            return 0.0
        }
        return -1.0
    }
    
}

extension SemesterTVC: UITableViewDataSource, UITableViewDelegate {

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mystudents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SemesterCustomCell", for: indexPath) as! SemesterTableViewCell
       
//        cell.textLabel?.text = "Second View Row " + String((indexPath as NSIndexPath).row)
        cell.classLabel.text = mystudents[indexPath.row].title
//        print("TEST \(mystudents[indexPath.row].grade[indexPath.row])")
 //      cell.firstWeekLabel.text = mystudents[indexPath.row].grade[indexPath.row]
        cell.secondWeekLabel.text = mystudents[indexPath.row].grade2[indexPath.row]
//        cell.examLabel.text = mystudents[indexPath.row].examGrade[indexPath.row]
       // cell.avgLabel.text = mystudents[indexPath.row].semesterGrade
         cell.avgLabel.text = mystudents[indexPath.row].grade2[indexPath.row]
 
//
//
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 65.0
//    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
 
        tableView.deselectRow(at: indexPath, animated: true)
        }
//                    print("Selected \(indexPath.row)")
//                //loadClass(myurl: "https://gradebook.pisd.edu/Pinnacle/Gradebook/InternetViewer/\(mystudents[indexPath.row].classView)")
//        var courseTier = 4.0
//        var courseFinaltier = 0.0
//        //let myInt3 = myterms[2].grades[indexPath.row].index(of: "%")
//        //if(myInt3 != nil) {
//            //let myInt3 = myterms[2].grades[indexPath.row].substring(to: myInt3!)
//
//           // let trueInt3 = Int(myInt3)
//         courseTier = getLevel(courseName: mystudents[0].title)//(courseName: , courseAvg: trueInt3!)
//             courseFinaltier = getTier(level: courseTier, grade: calcAve)
//
//        let alert = UIAlertController(title: mystudents[0].title, message: "Class Info: \n First Nine Weeks: \(myterms[0].grades[indexPath.row])\nSecond Nine Weeks: \(myterms[1].grades[indexPath.row])\nExam: N/A\n Average: \(calcAve)\n Tier: \(courseFinaltier)", preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//
   
}

extension SemesterTVC: SJSegmentedViewControllerViewSource {
    
    func viewForSegmentControllerToObserveContentOffsetChange() -> UIView {
        
        return nineWeekTable
    }
}
