//
//  Parser.swift
//  Gradebook
//
//  Created by Yonathan Zetune on 6/19/17.
//  Copyright © 2017 Yoni Zetune. All rights reserved.
//

import Foundation
import SwiftSoup
import WebKit
import UIKit
enum HTMLError: Error {
    case badInnerHTML
}

class Parser  {
    var examCount = 0
    var counter = 0
    var classCounter = 0.0
    var stuGPA = 0.0
    var gpaPNTS = 0.0
    var goodCredentials = 0
    var students = [Student]()
    var termReports = [TermReport]()
    var parseObjs = [Any]()
    init(_ innerHTML: Any?) throws {
        guard let htmlString = innerHTML as? String else { throw HTMLError.badInnerHTML }
        let doc = try SwiftSoup.parse(htmlString)
        let htmlHeader = try doc.getElementById("Head1")
        let htmlErrorHeader = try doc.select("div[class=content]")
        //print(try htmlErrorHeader.text())
        if (try htmlErrorHeader.text().contains("Server Error")) {
   
            goodCredentials = 2
            
            
        }
        
       else if (try htmlHeader?.text() == "Logon") {
            goodCredentials = 1
            //print("bad creds")
           
        } else {
            
        let contentMain = try doc.select("div[id=ContentMain]")
        //print(contentMain.isEmpty)
        let year630 = try contentMain.get(0).select("div[class=grid collapse in]")
            ////print(try year630.html())
        var row = try year630.get(0).select("div[class=row]").array()

       var numPer = try year630.get(0).select("div[class=row]").array().count
          //  for var i in 0..<(numPer) {
            var i = 0
            repeat {
                numPer = try year630.get(0).select("div[class=row]").array().count
                
                print(try year630.get(0).select("div[class=row]").array().count, "\(i)")
                
                if !(try year630.get(0).select("div[class=row]").array()[i].text().contains("3rd Nine Weeks")) {
                    //try row[i].select("div[class=letter-label]").text().contains("3rd Nine Weeks")
                    print(try row[i].select("div[class=letter-label]").text())
                    
                    try year630.get(0).select("div[class=row]").array()[i].remove()
                    if  (i != 0){
                  i -= 1
                    }
                     print(i)
                    //print(try row[i].select("div[class=letter-label]").text())
                     print("REMOVED")
                    //print(try year630.get(0).select("div[class=row]").array())
                    //courseDetailWeeks.append(courseDetailWeeks0[i])
                    //print(try courseDetailWeeks0[i].select("div[class=letter-label]").text())
                //}
                } else{i+=1}
                
            }while (i < numPer)
            row = try year630.get(0).select("div[class=row]").array()
//        let priorClasses = try year630.get(0).select("div[class=heading]").array()
//        let priorRows = try priorClasses[0].select("div[class=row]").array()
//            //print("PRIOR CLASSES: \(priorClasses)")
//            //print("PRIOR ROWS: \(priorRows.count)")
            ////print(try row[1].text())
            var termNames = ["","","","","","",""]
             //print(try termsArray[0].text())

            var finalTerms = [String]()
            for i in 0..<termNames.count {
                if (termNames[i] != "") {
                    finalTerms.append(termNames[i])
                }
                
            }
        let authors = try year630.get(0).getElementsByClass("period").array()//try doc.getElementsByClass("period").array()
        //print(try authors[1].text())
        let titles = try year630.get(0).getElementsByClass("course").array() //doc.getElementsByClass("course").array()
        let infos1 = try doc.select("section[id=Main]").array()//("Main")?.getElementsByTag("span").array()
            let infos = try infos1[0].getElementsByTag("span").array()
      //  let grades = try row[4].select("div[class=letter]").array()
        
            var students = [Student]()
        ////print("year630 \(year630.size())")
            var gradesFirst = [String]()
            var gradesSecond = [String]()
            var gradesThird = [String]()
        var grade = ""
            var finalString = ""
            var finalString2 = ""
            var examString = [String]()
        for i in 0..<titles.count{
            let author = try authors[i].text()
            let title = try titles[i].text()
            let courseDetailSem = try row[i].select("a[class=letter-container semester]").array()//getElementsByAttribute("href").array()
            ////print(try courseDetail[9].attr("href"))
            let courseDetailWeeks = try row[i].select("a[class=letter-container]").array()
            
            var semesterGrade = ""
            var gradesTwo = [Element]()
            var gradesThree = [Element]()
            var gradeExam = [Element]()
            var grade = "NONE"
            var grade2 = "NONE2"
            var semExam = "X"
            
    
                gradesTwo = try courseDetailWeeks[1].select("div[class=letter]").array()
                gradesThree = try courseDetailWeeks[0].select("div[class=letter]").array()
                grade = try gradesThree[0].text()
                 grade2 = try gradesTwo[0].text()
                gradeExam = try courseDetailWeeks[0].select("div[class=letter]").array()
                semExam = try gradeExam[0].text()
                semesterGrade = try courseDetailSem[0].select("div[class=letter").text()
            
            //let gradesOne = try courseDetailWeeks[0].select("div[class=letter]").array()
          //  if(!gradesThree[0].hasText()){}
      
         
            
            //print("FIRST GRADE: \(grade)")
           
            for j in 0..<courseDetailWeeks.count{
            if try courseDetailWeeks[j].select("div[class=letter-label]").text() == "3rd Nine Weeks" {
             finalString = try courseDetailWeeks[j].attr("href")
                print("FINAL STRING: \(finalString)")
             gradesSecond.append(grade2)
            }
                }
            
            
//            if try courseDetailWeeks[j].select("div[class=letter-label]").text() == "2nd Semester Exam" {
//                    finalString2 = try courseDetailWeeks[j].attr("href")
//                    //print("FINAL STRING: \(finalString)")
//                    gradesSecond.append(grade2)
//                }
//                if try courseDetailWeeks[j].select("div[class=letter-label]").text() == "1st Semester Exam" {
//                    examString.append(semExam)
//                }
                
            
            let newdetail = (String(describing: courseDetailSem[0]))
            let index1 = newdetail.index(newdetail.startIndex, offsetBy: 9)
            let newdetail2 = newdetail.substring(from: index1)
         
            if (semesterGrade != "") {
                self.classCounter += 1
            let gradePercentIndex = semesterGrade.index(of: "%")
            let finalGrade = semesterGrade.substring(to: gradePercentIndex!)
                let intFinalGrade = Int(finalGrade)!
               
            //print("GRADE NO PER: \(String(describing: intFinalGrade))")
                if(title.contains(" AP") || title.contains(" L") || title.contains(" IB")){
                    if(intFinalGrade >= 97){
                        gpaPNTS += 5.0
                    }
                    if(intFinalGrade >= 93 && intFinalGrade < 97){
                        gpaPNTS += 4.8
                    }
                    if(intFinalGrade >= 90 && intFinalGrade < 93){
                        gpaPNTS += 4.6
                    }
                    if(intFinalGrade >= 87 && intFinalGrade < 90){
                        gpaPNTS += 4.4
                    }
                    if(intFinalGrade >= 83 && intFinalGrade < 87){
                        gpaPNTS += 4.2
                    }
                    if(intFinalGrade >= 80 && intFinalGrade < 83){
                        gpaPNTS += 4.0
                    }
                    if(intFinalGrade >= 77 && intFinalGrade < 80){
                        gpaPNTS += 3.8
                    }
                    if(intFinalGrade >= 73 && intFinalGrade < 77){
                        gpaPNTS += 3.6
                    }
                    if(intFinalGrade >= 71 && intFinalGrade < 73){
                        gpaPNTS += 3.4
                    }
                    if(intFinalGrade == 70){
                        gpaPNTS += 3.0
                    }
                    
                    
                }
                let honorInd = title.index(of: "H")
                 if (honorInd == title.endIndex){
                    if(intFinalGrade >= 97){
                        gpaPNTS += 4.5
                    }
                    if(intFinalGrade >= 93 && intFinalGrade < 97){
                        gpaPNTS += 4.3
                    }
                    if(intFinalGrade >= 90 && intFinalGrade < 93){
                        gpaPNTS += 4.1
                    }
                    if(intFinalGrade >= 87 && intFinalGrade < 90){
                        gpaPNTS += 3.9
                    }
                    if(intFinalGrade >= 83 && intFinalGrade < 87){
                        gpaPNTS += 3.7
                    }
                    if(intFinalGrade >= 80 && intFinalGrade < 83){
                        gpaPNTS += 3.5
                    }
                    if(intFinalGrade >= 77 && intFinalGrade < 80){
                        gpaPNTS += 3.3
                    }
                    if(intFinalGrade >= 73 && intFinalGrade < 77){
                        gpaPNTS += 3.1
                    }
                    if(intFinalGrade >= 71 && intFinalGrade < 73){
                        gpaPNTS += 2.9
                    }
                    if(intFinalGrade == 70){
                        gpaPNTS += 2.5
                    }
                    
                    
                }
                if (!(title.contains(" AP") || title.contains(" L") || title.contains(" IB") || honorInd == title.endIndex)) {
                    if(intFinalGrade >= 97){
                        gpaPNTS += 4.0
                    }
                    if(intFinalGrade >= 93 && intFinalGrade < 97){
                        gpaPNTS += 3.8
                    }
                    if(intFinalGrade >= 90 && intFinalGrade < 93){
                        gpaPNTS += 3.6
                    }
                    if(intFinalGrade >= 87 && intFinalGrade < 90){
                        gpaPNTS += 3.4
                    }
                    if(intFinalGrade >= 83 && intFinalGrade < 87){
                        gpaPNTS += 3.2
                    }
                    if(intFinalGrade >= 80 && intFinalGrade < 83){
                        gpaPNTS += 3.0
                    }
                    if(intFinalGrade >= 77 && intFinalGrade < 80){
                        gpaPNTS += 2.8
                    }
                    if(intFinalGrade >= 73 && intFinalGrade < 77){
                        gpaPNTS += 2.6
                    }
                    if(intFinalGrade >= 71 && intFinalGrade < 73){
                        gpaPNTS += 2.4
                    }
                    if(intFinalGrade == 70){
                        gpaPNTS += 2.0
                    }
                }
                
            }
            stuGPA = gpaPNTS/classCounter
          
            let stringstuGPA = String(stuGPA)
            
            let indexSecQuo = newdetail2.index(of: "\"")
            let nextString = newdetail2.substring(to: indexSecQuo!)
            
           // attr("href")//nextString.replacingOccurrences(of: "amp;", with: "")
           // let finalString = try courseDetailSem[0].attr("href")
           
            let studInfo = try infos[0].text()
            let newStudent = Student(author: author, title: title, grade: gradesFirst, grade2: gradesSecond, examGrade: examString, studentInfo: studInfo, classView: finalString, classView2: finalString2, terms: finalTerms, maxTerms: finalTerms.count, gpa: stringstuGPA, semesterGrade: semesterGrade)
            students.append(newStudent)
            //print(author)
            //print(title)
            //print(finalString)
            //print("-----")
          
            ////print(String(describing: courseDetail[0]))
            
            
            
            
        }
        
        self.students = students
       // self.termReports = termArray
        self.parseObjs.append(self.students)
        self.parseObjs.append(self.termReports)
    }
    
}
    
    
    
}
extension String {
    func index(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    func endIndex(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    func indexes(of string: String, options: CompareOptions = .literal) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range.lowerBound)
            start = range.upperBound
        }
        return result
    }
    func ranges(of string: String, options: CompareOptions = .literal) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range)
            start = range.upperBound
        }
        return result
    }
}
