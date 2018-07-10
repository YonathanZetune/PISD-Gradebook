//
//  ClassParser.swift
//  Gradebook
//
//  Created by Yonathan Zetune on 6/27/17.
//  Copyright © 2017 Yoni Zetune. All rights reserved.
//

import Foundation
import SwiftSoup
import WebKit
import UIKit
//enum HTMLError: Error {
//    case badInnerHTML
//}

class ClassParser  {
    //var counter = 0
    //var goodCredentials = true
    var classAssignments = [Assignment]()
    
    init(_ innerHTML: Any?) throws {
        guard let htmlString = innerHTML as? String else { throw HTMLError.badInnerHTML }
        let doc = try SwiftSoup.parse(htmlString)
        let htmlHeader = try doc.getElementById("ctl00_ctl00_Head1")
        print(try htmlHeader?.text())
        if (try htmlHeader?.text() != "Assignments") {
           // goodCredentials = false
            print("bad creds")
            
        } else {
            let assignhead = try doc.getElementById("Assignments")
           // print("Assignment \(assignhead)")
            let assignments = try doc.select("div[class=title]").array()
            //print(try assignments[0].text())
            let gradeVals = try assignhead?.select("td[class=letter]").array()//"span[class=points]"
            let gradeDescrip = try assignhead?.select("td[class=description]").array()
            let gradeW = try assignhead?.select("td[class=numeric]").array()
            let findDate = try assignhead?.select("td[class=icon-date]").array()
            var gradeWeights = [String]()
            var gradeDates = [String]()
            var gradeCats = [String]()
            var gradePercs = [String]()
            var gradeOverCats = [String]()
            var gradeCatPNTS = [String]()
            let classOverCats = try doc.getElementById("Categories")
            let classSpecCats = try classOverCats?.select("td[class=description]").array()
            let catPNTSArray = try classOverCats?.select("td[class=letter]").array()
            if let newCats = classSpecCats {
            for i in 0..<newCats.count{
                let newCatsIndex = try newCats[i].text().index(of: "%")
                let newCatsIndex2 = try newCats[i].text().index(newCatsIndex!, offsetBy: -2)
                gradeOverCats.append(try newCats[i].text().substring(to: newCatsIndex2))
                print("TYPE:  \(try newCats[i].text())")
                gradeCatPNTS.append((try catPNTSArray![i].getElementsByTag("span").text()))
            }
        }
            if let newGradeDes = gradeDescrip {
            for i in 0..<newGradeDes.count {
                let compareMe = try gradeW![i].select("span[class=weight]")
            
                if(try compareMe.text() != "") {
                    gradeWeights.append(try gradeW![i].text())
                } else {
                    gradeWeights.append("1.0")
                }
            }
            }
            if let newGradeDates = findDate {
                for i in 0..<newGradeDates.count {
                    let compareMe = try newGradeDates[i].select("time[class=date-due]")
                    let assignCategory = try gradeDescrip![i].select("div[class=category]")//.array()
                    let compPer = try gradeVals![i].select("div[class=letter")
                    if(try compareMe.text() != "") {
                        gradeDates.append(try newGradeDates[i].text())
                    } else {
                        gradeDates.append("N/A")
                    }
                    if(try assignCategory.text() != "") {
                        gradeCats.append(try gradeDescrip![i].text())
                    } else {
                        gradeCats.append("N/A")
                    }
                    if(try compPer.text() != "") {
                        gradePercs.append(try gradeVals![i].text())
                    } else {
                        gradePercs.append("N/A")
                    }
                }
            }
            
            
               var classAssignments = [Assignment]()
            for i in 0..<assignments.count {
                let finalDates = gradeDates[i]
                let weights = gradeWeights[i]
                let assignName = try assignments[i].text()
                print(assignName)
                let assignmentGrade = gradePercs[i]
                let category = gradeCats[i]
              let gradePercentIndex = assignmentGrade.index(of: "%")
//              let finalGrade = assignmentGrade.substring(to: gradePercentIndex!)
//                let intFinalGrade = Int(finalGrade)
//                print("GRADE NO PER: \(intFinalGrade)")
                
                let newClass = Assignment(name: assignName, category: category, dueDate: finalDates, weight: weights, grade: assignmentGrade, maxGrade: 3.0, categories: gradeOverCats, categoriesPNTS: gradeCatPNTS)
         //newClass.categories = gradeOverCats
               classAssignments.append(newClass)
            //classAssignments.append(newClass1)
            }
//                print(author)
//                print(title)
//                print(finalString)
//                print("-----")
        
            
            
            self.classAssignments = classAssignments
            
        }
        
    }

}

