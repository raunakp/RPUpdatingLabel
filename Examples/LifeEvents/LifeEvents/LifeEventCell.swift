//
//  TableViewCell.swift
//  LifeEvents
//
//  Created by Raunak Poddar on 06/09/19.
//  Copyright © 2019 Raunak Poddar. All rights reserved.
//

import UIKit
import RPUpdatingLabel

class LifeEventCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var elapsedTimeLabel: RPUpdatingLabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
