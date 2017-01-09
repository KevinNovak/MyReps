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
        
        let apiURL = "https://congress.api.sunlightfoundation.com"
        let latitude = 41.373427
        let longitude = -81.689911
        let legislatorsURL = apiURL + "/legislators/locate?latitude=" + String(latitude) + "&longitude=" + String(longitude)
    
        let url = URL(string: legislatorsURL)
        
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                if let legislators = json["results"] as? [[String:Any]] {
                    for legislator in legislators {
                        if let firstName = legislator["first_name"] as? String {
                            if let lastName = legislator["last_name"] as? String {
                                print(firstName + " " + lastName)
                            }
                        }
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        }).resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

