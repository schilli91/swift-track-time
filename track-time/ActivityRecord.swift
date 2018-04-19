//
//  ActivityRecord.swift
//  track-time
//
//  Created by Moritz Schillinger on 16.04.18.
//  Copyright © 2018 Moritz Schillinger. All rights reserved.
//

import Foundation

class ActivityRecord {
//  TODO: start and stop time must be integers storing minutes / seconds ?
    var startTime: Int?
    var stopTime: Int?
    var breakTime: Int?
    
    init() {
        
    }
    
    func getDurationString() -> String {
        let diff = stopTime! - startTime!
        if diff >= 86400 {
            // TODO: do something when start and stop are on different days.
        }
        
        return Date(timeIntervalSince1970: TimeInterval(startTime!)).toString(dateFormat: "dd.MM.YYYY HH:mm") + " - " + Date(timeIntervalSince1970: TimeInterval(stopTime!)).toString(dateFormat:"HH:mm")
    }
    
    func getActivityDuration() -> String {
        let activityDuration = (stopTime! - startTime!) / 60
        
        let activityMinutes = activityDuration % 60
        let activityHours = activityDuration / 60
        
        let minutesLeadingZero = activityMinutes > 9 ? "" : "0"
        let hoursLeadingZero = activityHours > 9 ? "" : "0"
        
        return hoursLeadingZero + String(activityHours) + ":" + minutesLeadingZero + String(activityMinutes)
    }
}
