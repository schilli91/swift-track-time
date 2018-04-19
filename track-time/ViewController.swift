//
//  ViewController.swift
//  track-time
//
//  Created by Moritz Schillinger on 09.04.18.
//  Copyright © 2018 Moritz Schillinger. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var activityTable: UITableView!
    
    @IBOutlet weak var startText: UITextField!
    @IBOutlet weak var stopText: UITextField!
    @IBOutlet weak var breakText: UITextField!
    
    var currentActivity = ActivityRecord()
    var activities = [ActivityRecord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        activityTable.delegate = self
        activityTable.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ActivityTableViewCell = activityTable.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell
        
        cell.activity = activities[indexPath.row]
        
//      startStopLabel is optional.
        cell.startStopLabel!.text = cell.getStartStopText()
        cell.timeLabel!.text = cell.getActivityDuration()
        
        return cell
    }
    
    @IBAction func startRecording(_ sender: UIButton) {
        currentActivity.startTime = Date()
        startText.text = currentActivity.startTime!.toString(dateFormat: "dd.MM.YYYY HH:mm:ss")
    }
    
    @IBAction func stopRecording(_ sender: UIButton) {
        if currentActivity.startTime == nil{
            os_log("startTime not set!", type:.info)
            return
        }
        currentActivity.stopTime = Date()
        stopText.text = currentActivity.stopTime!.toString(dateFormat: "dd.MM.YYYY HH:mm:ss")

        activities.append(currentActivity)
        activityTable.insertRows(at: [IndexPath(row: activities.count-1, section: 0)], with: .automatic)
        
        //      TODO: currentActivity neu initialisieren, damit die Referenz nicht auf das gleiche Objekt zeigt.
    }
    
}

