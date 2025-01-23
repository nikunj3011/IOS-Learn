//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var totalTime = 0
    var secondsPassed = 0
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    
    var secondsRemaining = 60
    var timer = Timer()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        print(totalTime)
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if secondsPassed < totalTime {
            let percentageProgress = Float(secondsPassed)/Float(totalTime)
            progressBar.progress = Float(percentageProgress)
            print(percentageProgress)
            secondsPassed += 1
        }else{
            progressBar.progress = Float(1)
            timer.invalidate()
            titleLabel.text = "Done!"
        }
    }
    
}
