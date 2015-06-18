//
//  ViewController.swift
//  CronoTv
//
//  Created by Ferran Olivella on 20/2/15.
//  Copyright (c) 2015 Ferran Olivella. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var main_counter: UILabel!
    @IBOutlet weak var lap_counter: UILabel!
    
    @IBOutlet weak var btn_play: UIButton!
    @IBOutlet weak var btn_lap: UIButton!
    
    var lap: NSTimeInterval!
    var last_lap: NSTimeInterval!
    var lapping = false
    var RESET_TIMER_STR: String! = "00.00.00"
    
    private var running = false
    private var timer = NSTimer()
    private var dateFormatter = NSDateFormatter()
    private var startDate: NSDate!
    private var timeString: NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        remakeTheButtons()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func someButtonPressed(sender: AnyObject) {
        var btn_pressed = sender as! UIButton
        var title:String! = btn_pressed.titleLabel?.text!
        switch title {
            case "Play":
                printButtonPressed(title)
                btn_pressed.setTitle("Pause", forState: .Normal)
                startButtonTapped()
            case "Pause":
                printButtonPressed(title)
                btn_pressed.setTitle("Play", forState: .Normal)
                startButtonTapped()
            case "Reset":
                printButtonPressed(title)
                resetButtonTapped()
            case "Lap":
                printButtonPressed(title)
                lapButtonTapped()
            default:
                println("Some another button has been pressed.")
        }
    }
    
    func printButtonPressed(title: String) {
        println("\(title) pressed")
    }
    
    func remakeTheButtons() {
        // Make rounded buttons
//        btn_play.layer.cornerRadius = 0.5 * btn_play.bounds.size.width
//        btn_lap.layer.cornerRadius = 0.5 * btn_lap.bounds.size.width
        
        // Add border
//        btn_play.layer.borderWidth = 1
//        btn_lap.layer.borderWidth = 1
        
        // Add color to border
//        btn_play.layer.borderColor = UIColor.greenColor().CGColor
//        btn_lap.layer.borderColor = UIColor.greenColor().CGColor
    }
    
    func update() {
        var currentDate: NSDate = NSDate()
        var timeInterval: NSTimeInterval = currentDate.timeIntervalSinceDate(startDate)
        var timerDate = NSDate(timeIntervalSince1970: timeInterval)
        
        dateFormatter.dateFormat = "mm:ss:SS"
        
        timeString = dateFormatter.stringFromDate(timerDate)
        main_counter.text = timeString as? String
    }
    
    func startButtonTapped() {
        if (!running) {
            startDate = NSDate()
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0/100.0, target: self, selector: Selector("update"), userInfo: nil, repeats:true)
            running = true
        } else {
            running = false
            timer.invalidate()
        }
    }
    
    // TODO: Realment contar cada volta. Cada vegada que s'apreti lap, s'ha de comptar el temps que es porta desde l'última "lap".
    func lapButtonTapped() {
        lap_counter.text = main_counter.text
//        lapping = true
    }
    
    func resetButtonTapped() {
        timer.invalidate()
        main_counter.text = RESET_TIMER_STR
        lap_counter.text = RESET_TIMER_STR
    }
}

