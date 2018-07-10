//
//  GradeCategory.swift
//  yourPISD
//
//  Created by Yonathan Zetune on 5/30/17.
//  Copyright © 2017 Yoni Zetune. All rights reserved.
//

import Foundation
import UIKit

public class GradeCategory {
    
    public static var  NO_CATEGORY = "No category"
    
    private final var type : String?
    private final var weight : Double?
    private var grade = -1;

    
    init(type: String, weight: Double){
    self.type = type
    self.weight = weight
    }
    
    func getType() -> String  {
    return type!
    }
    
    func getWeight() -> Double  {
    return weight!
    }
    
    func getGrade() -> Int  {
    return grade
    }
    
    func setGrade(grade : Int ) -> Void  {
    self.grade = grade
        
    }
    
    //override
    func equals(o : AnyObject) -> Bool {
        let that = o as? GradeCategory
        
        if (self === that){
        return true;
        }
        if (o == nil || getType() != o.typeIdentifier){
            
        return false;
        }

        if (weight != that?.weight){
        return false;
        }
    return ((type?.compare((that?.getType())!)) != nil);
    }
    

    func hashCode() -> Int{
    var  result : Int
    var  temp : CLong
        if (type != nil){
        result = hashCode()
        }
        else{
        result = 0;
        }
        //type != null ? type.hashCode() : 0;
    temp = weight as! Int
        //Double.significandBitCount(weight);
    result = 31 * result +  (temp ^ (temp / 2));
    return result;
    }
    
    
    
    
    
    
    
    
    
}
