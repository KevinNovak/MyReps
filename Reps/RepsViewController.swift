//
//  RepsViewController.swift
//  Reps
//
//  Created by Kevin Novak on 1/8/17.
//  Copyright © 2017 Kevin Novak. All rights reserved.
//

import UIKit

class RepsViewController: UIViewController {
    var reps: [[String:Any]] = [[String:Any]]()
    
    @IBOutlet weak var repsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for rep in self.reps {
            if let firstName = rep["first_name"] as? String {
                if let lastName = rep["last_name"] as? String {
                    if (self.repsLabel.text == "{REPS}") {
                        self.repsLabel.text = ""
                    }
                    
                    let fullName = firstName + " " + lastName
                    self.repsLabel.text = self.repsLabel.text! + fullName + "\n"
                    
                    self.repsLabel.lineBreakMode = .byWordWrapping
                    self.repsLabel.numberOfLines = 0
                }
            }
        }
    }
    

}

