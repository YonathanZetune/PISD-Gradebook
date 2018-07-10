//
//  ClassReport.swift
//  yourPISD
//
//  Created by Yonathan Zetune on 6/3/17.
//  Copyright © 2017 Yoni Zetune. All rights reserved.
//

import Foundation

public class ClasssReport{
    
    public static var SEMESTER_TERMS = 3;
    public static var NUM_TERMS = SEMESTER_TERMS * 2;
    
    private final var classID = 0 //Unique ID that identifies which class this is.
    //private final var TermReport terms[] = new TermReport[NUM_TERMS]; //Terms in this Class.
    private var periodNum = -1
    private var courseName = ""
    private var teacherName = ""
    
    init(classID : Int, courseName : String) {
    self.classID = classID;
    self.courseName = courseName;
    }
    
//   public TermReport getTerm(int termNum) {
//    return terms[termNum];
//    }
   
    
}
