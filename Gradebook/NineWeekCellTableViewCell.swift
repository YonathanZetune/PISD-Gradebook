//
//  NineWeekCellTableViewCell.swift
//  Gradebook
//
//  Created by Yonathan Zetune on 6/26/17.
//  Copyright © 2017 Yoni Zetune. All rights reserved.
//

import UIKit

class NineWeekCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var gradeLabel: UILabel!
    
    @IBOutlet weak var periodLabel: UILabel!
    
    @IBOutlet weak var classLabel: UILabel!
//    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
