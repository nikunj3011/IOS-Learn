// ViewController.swift

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var meditateButton: UIButton!
    @IBOutlet weak var sleepButton: UIButton!
    @IBOutlet weak var moveButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var podcastsButton: UIButton!
    @IBOutlet weak var trialButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleButton(meditateButton, bgColor: UIColor.systemOrange)
        styleButton(sleepButton, bgColor: UIColor.purple)
        styleButton(moveButton, bgColor: UIColor.systemPink)
        styleButton(musicButton, bgColor: UIColor.systemBlue)
        styleButton(podcastsButton, bgColor: UIColor.systemYellow)
        styleTrialButton(trialButton)
    }

    func styleButton(_ button: UIButton, bgColor: UIColor) {
        button.backgroundColor = bgColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }

    func styleTrialButton(_ button: UIButton) {
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
}
