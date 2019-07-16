//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Sandi Ma on 6/21/19.
//  Copyright © 2019 Sandi Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let ballArray = ["ball1", "ball2", "ball3", "ball4", "ball5"]
    var randomBallNumber: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newBallImageRandomly()
    }

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func askButtonPressed(_ sender: Any) {
         newBallImageRandomly()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
       newBallImageRandomly()
    }
    
    func newBallImageRandomly() {
        randomBallNumber = Int.random(in: 0...4)
        imageView.image = UIImage (named: ballArray[randomBallNumber])
    }
}

