//
//  ViewController.swift
//  Reps
//
//  Created by Kevin Novak on 1/8/17.
//  Copyright © 2017 Kevin Novak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let urlString = "https://httpbin.org/ip"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error ?? "Error")
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:String]
                    let ip = parsedData["origin"]
                    print("ip: " + ip!)

                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

