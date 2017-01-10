//
//  AddressViewController.swift
//  Reps
//
//  Created by Kevin Novak on 1/10/17.
//  Copyright © 2017 Kevin Novak. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController {

    @IBOutlet weak var addressField: UITextField!
    
    override func viewDidLoad() {
        
    }
    @IBAction func submitAddressButtonPressed(_ sender: Any) {
        print(addressField.text)
        
        // Instantiate SecondViewController
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "RepsViewController") as! RepsViewController
        
        // Set "Hello World" as a value to myStringValue
        secondViewController.address = addressField.text!
        
        // Take user to SecondViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}
