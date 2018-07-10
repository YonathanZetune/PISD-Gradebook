//
//  Session.swift
//  yourPISD
//
//  Created by Yonathan Zetune on 5/30/17.
//  Copyright © 2017 Yoni Zetune. All rights reserved.
//

import Foundation
import AssetsLibrary
import UIKit
import SwiftSoup
import WebKit
protocol Session {
    // static var userWebView = WKWebView!()
    
    var students: [Student]! {get set}
    
    func setStuds(newStu: [Student]) -> Void
}
