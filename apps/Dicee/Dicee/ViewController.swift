//
//  ViewController.swift
//  Dicee
//
//  Created by Sandi Ma on 6/18/19.
//  Copyright © 2019 Sandi Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let diceArray = ["dice1","dice2","dice3","dice4","dice5","dice6" ]
    var randomDiceIndex1: Int = 0
    var randomDiceIndex2: Int = 0
    
    
    @IBOutlet weak var diceImageView1: UIImageView!
    
    @IBOutlet weak var diceImageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDiceImagesRandomyly()
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        updateDiceImagesRandomyly()
  }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateDiceImagesRandomyly()
    }
    
    func updateDiceImagesRandomyly() {
        randomDiceIndex1 = Int.random(in: 0...5)
        randomDiceIndex2 = Int.random(in: 0...5)
        
        diceImageView1.image = UIImage(named: diceArray[randomDiceIndex1])
        
        diceImageView2.image = UIImage(named: diceArray[randomDiceIndex2])

    }
}

