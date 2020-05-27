//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //UI Elements
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var bitcoinLbl: UILabel!
    
    //Object
    var coinManagerRef = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
    }


}

//MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    
func numberOfComponents(in pickerView: UIPickerView) -> Int {
    
    return 1
}

func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
    return coinManagerRef.currencyArray.count
}
    
}

//MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return coinManagerRef.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let currencySelected = coinManagerRef.currencyArray[row]
        
        coinManagerRef.getCoinPrice(for: currencySelected)
    }
    
}

