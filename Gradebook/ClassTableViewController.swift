//
//  ClassTableViewController.swift
//  Gradebook
//
//  Created by Yonathan Zetune on 6/27/17.
//  Copyright © 2017 Yoni Zetune. All rights reserved.
//

import UIKit
import SJSegmentedScrollView
import WebKit
class ClassTableViewController: HeaderViewController {
    
    @IBOutlet weak var classTableView: UITableView!

    @IBAction func backPressed(_ sender: Any) {
    }
    
   
    func swipeleft(gestureRecognizer: UISwipeGestureRecognizer) {
        //Do what you want here
       self.dismiss(animated: true, completion: nil)
       // self.navigationController?.popViewController(animated: true)
        //Pop back to login view controller
        
    }
    var myAssignments: [Assignment]!
    
    var classStuds: [Student]!
    override func viewDidLoad() {
          dump(myAssignments)
        let swipeleft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ClassTableViewController.swipeleft(gestureRecognizer:)))
        swipeleft.direction = .right
        self.view!.addGestureRecognizer(swipeleft)
     
    }
    
   
        //super.viewDidLoad()
        //classTableView.delegate = self
        //classTableView.dataSource = self
        //print("ASSIGNS \(headAssignments.count)")
        
     
    
    


}
    extension ClassTableViewController: UITableViewDataSource, UITableViewDelegate  {
        
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1//myAssignments.count
    }
        
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (myAssignments.isEmpty != true) {
         return myAssignments.count + myAssignments[0].categories.count
        } else {
        return 0
        }
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassViewCell", for: indexPath)// as! NineWeekCellTableViewCell
        if(indexPath.row < myAssignments.count) {
        cell.textLabel?.text = myAssignments[indexPath.row].name
            
      cell.detailTextLabel?.text = myAssignments[indexPath.row].grade
        }
        else{
            //for i in 0..<myAssignments[0].categories.count {
            
            cell.textLabel?.text = myAssignments[0].categories[indexPath.row-myAssignments.count]
            cell.textLabel?.font = UIFont(name: "AvenirNext-Bold", size: 17)
            cell.detailTextLabel?.text = myAssignments[0].categoriesPNTS[indexPath.row-myAssignments.count]
          //  }
            //cell.detailTextLabel?.text = myAssignments[indexPath.row].grade
        }
//        if(indexPath.row == myAssignments.count) {
//            cell.textLabel?.text = "Major Evaluations"
//            cell.detailTextLabel?.text = "N/A"
//            cell.textLabel?.font = UIFont(name: "AvenirNext-Bold", size: 22)
//        }
//        if(indexPath.row == myAssignments.count+1) {
//            cell.textLabel?.text = "Daily Work"
//            cell.detailTextLabel?.text = "N/A"
//            cell.textLabel?.font = UIFont(name: "AvenirNext-Bold", size: 22)
//        }
        
        return cell
    }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.prepare()
            generator.impactOccurred()
            tableView.deselectRow(at: indexPath, animated: true)
             if(indexPath.row < myAssignments.count) {
            let alert = UIAlertController(title: myAssignments[indexPath.row].name + "- \(myAssignments[indexPath.row].grade)", message: "Assignment Info: \n \(myAssignments[indexPath.row].category)\nWeight: x\(myAssignments[indexPath.row].weight)\nDue Date: \(myAssignments[indexPath.row].dueDate)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            }
        }
 
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            var myReturn = 43.0
            if(!(indexPath.row < myAssignments.count)) {
                myReturn = 55.0
            }
            return CGFloat(myReturn)
        }
}
//extension ClassTableViewController: SJSegmentedViewControllerViewSource {
//    
//    func viewForSegmentControllerToObserveContentOffsetChange() -> UIView {
//        
//        return classTableView
//    }
//    
//    
//}
