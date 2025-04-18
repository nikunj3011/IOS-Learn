//
//  SecondViewController.swift
//  BMI Calculator
//
//  Created by Nikunj Rathod on 2025-03-01.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var bmi: String = "0.0"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = "Your BMI is: \(bmi)"
        label.frame = CGRect(x:0,y:0,width:100,height:50)
        view.addSubview(label)
        // Do any additional setup after loading the view.
    }
}
