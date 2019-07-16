//
//  SecondViewController.swift
//  SeguePractice2
//
//  Created by Sandi Ma on 7/9/19.
//  Copyright © 2019 Sandi Ma. All rights reserved.
//

import UIKit
// creating a protocol to help pass data back

protocol CanReceive {
    func dataReceived(data: String)
}
class SecondViewController: UIViewController {
    var delegate : CanReceive?
    var data = ""
   
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = data
        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendButtonBack(_ sender: Any) {
       delegate?.dataReceived(data: textField.text!)
        // we need to dismiss when the 2nd view controller is done and go back to the 1st view controller that is underneath
        dismiss(animated: true, completion: nil)
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
