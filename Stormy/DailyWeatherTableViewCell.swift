//
//  DailyWeatherTableViewCell.swift
//  Stormy
//
//  Created by Roberta Voulon on 2015-10-14.
//  Copyright © 2015 Roberta Voulon. All rights reserved.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var temperatureLabel: UILabel?
    @IBOutlet weak var weatherIcon: UIImageView?
    @IBOutlet weak var dayLabel: UILabel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
