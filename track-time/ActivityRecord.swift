//
//  ActivityRecord.swift
//  track-time
//
//  Created by Moritz Schillinger on 16.04.18.
//  Copyright © 2018 Moritz Schillinger. All rights reserved.
//

import Foundation

class ActivityRecord {
    var startTime: Date?
    var stopTime: Date?
    
    init() {
        
    }
    
    func getDurationString() -> String {
        let diff = stopTime?.interval(ofComponent: .day, fromDate: startTime!)
        if diff! > 0 {
            return startTime!.toString(dateFormat: "dd.MM.YYYY HH:mm") + " - " + stopTime!.toString(dateFormat:"dd.MM.YYYY HH:mm")
        }
        
        return startTime!.toString(dateFormat: "dd.MM.YYYY HH:mm") + " - " + stopTime!.toString(dateFormat:"HH:mm")
    }
    
    func getActivityDuration() -> String {
        let activityDuration = stopTime?.interval(ofComponent: .minute, fromDate: startTime!)
        
        let activityMinutes = activityDuration! % 60
        let activityHours = activityDuration! / 60
        
        let minutesLeadingZero = activityMinutes > 9 ? "" : "0"
        let hoursLeadingZero = activityHours > 9 ? "" : "0"
        
        return hoursLeadingZero + String(activityHours) + ":" + minutesLeadingZero + String(activityMinutes)
    }
}
