//
//  SemesterTableViewCell.swift
//  Gradebook
//
//  Created by Yonathan Zetune on 6/27/17.
//  Copyright © 2017 Yoni Zetune. All rights reserved.
//

import UIKit

class SemesterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avgLabel: UILabel!
    
    @IBOutlet weak var examLabel: UILabel!
    
    @IBOutlet weak var secondWeekLabel: UILabel!
    
    
    @IBOutlet weak var firstWeekLabel: UILabel!

    @IBOutlet weak var classLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
