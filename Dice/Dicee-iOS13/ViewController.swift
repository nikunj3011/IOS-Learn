//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        firstImage.image = UIImage(named: "DiceOne")
        secondImage.image = UIImage(named: "DiceTwo")
    }

    @IBAction func rollBtnPressed(_ sender: UIButton) {
//        print("sasasa")
        var c = [UIImage(named: "DiceOne"),               UIImage(named: "DiceTwo"),
                 UIImage(named: "DiceThree"),
                 UIImage(named: "DiceFour"),
                 UIImage(named: "DiceFive"),
                 UIImage(named: "DiceSix")]
        firstImage.image = c[Int.random(in:0...5)]
        secondImage.image = c[Int.random(in:0...5)]
    }
    
}

