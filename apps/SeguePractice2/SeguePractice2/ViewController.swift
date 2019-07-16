//
//  ViewController.swift
//  SeguePractice2
//
//  Created by Sandi Ma on 7/9/19.
//  Copyright © 2019 Sandi Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CanReceive {
    
  
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    @IBAction func blueButtonPressed(_ sender: Any) {
        view.backgroundColor = UIColor.blue
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "sendDataForward", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendDataForward" {
            let secondVC = segue.destination as! SecondViewController
            secondVC.data = textField.text!
            secondVC.delegate = self 
        }
    }
    // implementing the required delegate method when conforming with the protocol
    
    func dataReceived(data: String) {
        label.text = data
        }
    
}
