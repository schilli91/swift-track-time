//
//  ActivityTableViewCell.swift
//  track-time
//
//  Created by Moritz Schillinger on 09.04.18.
//  Copyright © 2018 Moritz Schillinger. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var startStopLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var activity: ActivityRecord?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getStartStopText() -> String {
        return activity!.getDurationString()
    }
    
    func getActivityDuration() -> String{
        return activity!.getActivityDuration()
    }

}
