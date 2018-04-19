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
    @IBOutlet weak var saveBtn: UIButton!
    
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
        
        startText.placeholder = "dd.mm.YYYY HH:mm:ss"
        stopText.placeholder = "dd.mm.YYYY HH:mm:ss"
        breakText.placeholder = "HH:mm"
        
        stopBtn.isEnabled = false
        saveBtn.isEnabled = false
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
        let now = Date()
        currentActivity.startTime = Int(now.timeIntervalSince1970)
        startText.text = now.toString(dateFormat: "dd.MM.YYYY HH:mm:ss")
        stopBtn.isEnabled = true
    }
    
    @IBAction func stopRecording(_ sender: UIButton) {
        if currentActivity.startTime == nil{
            os_log("startTime not set!", type:.info)
            return
        }
        let now = Date()
        currentActivity.stopTime = Int(now.timeIntervalSince1970)
        stopText.text = now.toString(dateFormat: "dd.MM.YYYY HH:mm:ss")
        saveBtn.isEnabled = true
    }
    
    @IBAction func saveActivity(_ sender: UIButton) {
        let breakComponents = breakText.text!.components(separatedBy: ":")
        if breakComponents.count > 1 {
            currentActivity.breakTime = Int(breakComponents[0])! * 60 + Int(breakComponents[1])!
        } else {
            currentActivity.breakTime = 0
        }
        
        activities.append(currentActivity)
        activityTable.insertRows(at: [IndexPath(row: activities.count-1, section: 0)], with: .automatic)
        
        currentActivity = ActivityRecord()
        startText.text = nil
        stopText.text = nil
        breakText.text = nil
        
        stopBtn.isEnabled = false
        saveBtn.isEnabled = false
        
        // Dismiss keyboard, after editing inputs.
        view.endEditing(true)
    }
    
    
}

