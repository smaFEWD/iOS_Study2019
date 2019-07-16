//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class BitcoinDataModel {
    // Declare your model variables here
    var highBid : Int = 0
    
}
class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    let currencySymbolArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var finalURL = ""
    var currencySelected = ""
    

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
       
    }

    //TODO: Place your 3 UIPickerView delegate methods here
    
    // our picker only has 1 component
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1

    }
    // number of rows is equal the number of currencies we have, which is the amount in our array
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }

    // looping through to give a string to a given row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }

    // what happens when a user lands on a particular row? What happens when that row is "picked?"
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalURL = baseURL + currencyArray[row]
        currencySelected = currencySymbolArray[row]
        // use the finalURL , so call the method to getBitcoinData
        getBitcoinData(url: finalURL)
        print(finalURL)
    }

//    
//    //MARK: - Networking
//    /***************************************************************/
//    
    func getBitcoinData(url: String) {

        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {

                    print("Sucess! Got the Bitcoin Data")
                    let bitcoinJSON : JSON = JSON(response.result.value!)

                    self.updateBitcoinData(json: bitcoinJSON)

                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
            }

    }
//
//
//    
//    
//    
//    //MARK: - JSON Parsing
//    /***************************************************************/
//    
    func updateBitcoinData(json: JSON){
        // this is using "optional binding" when we add an "if"..it means if it's not NIL then execute the code below "if"
        if let bitcoinResult = json["ask"].double{
            bitcoinPriceLabel.text = currencySelected + "\(bitcoinResult)"
        }
        else {
            bitcoinPriceLabel.text = "Price Unavailable"
        }
    }
    
//    func updateUIWithBitcoinData(){
//
//    }



}

