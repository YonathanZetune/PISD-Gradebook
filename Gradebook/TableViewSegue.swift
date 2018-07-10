//
//  TableViewSegue.swift
//  Gradebook
//
//  Created by Yonathan Zetune on 6/28/17.
//  Copyright © 2017 Yoni Zetune. All rights reserved.
//

import UIKit

class TableViewSegue: UIStoryboardSegue {
    
    override func perform() {
        scale()
    }
    
    func scale () {
       let toViewcontroller = self.destination
        let fromViewcontroller = self.source
        let containerView = fromViewcontroller.view.superview
        let originalCenter = fromViewcontroller.view.center
        toViewcontroller.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        toViewcontroller.view.center = originalCenter
        
        containerView?.addSubview(toViewcontroller.view)
        let fromP = fromViewcontroller.presentingViewController
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
        toViewcontroller.view.transform = CGAffineTransform.identity
        }, completion: { success in
            print("SEGUE")
            
            
            if fromP == nil {
                fromViewcontroller.present(toViewcontroller, animated: false, completion: nil)
            
            } else {
                //fromViewcontroller.dismiss(animated: false, completion: nil)
            }
            //fromViewcontroller.
            //fromViewcontroller.present(toViewcontroller, animated: false, completion: nil)
        })
        
        
        
        
    }
    
    
    
    
    
    
    
    

}
