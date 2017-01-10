//
//  RepsViewController.swift
//  Reps
//
//  Created by Kevin Novak on 1/8/17.
//  Copyright © 2017 Kevin Novak. All rights reserved.
//

import UIKit
import CoreLocation

class RepsViewController: UIViewController {
    var address = ""
    
    @IBOutlet weak var repsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Address: " + self.address)
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(self.address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                self.processCoordinates(coordinates: coordinates)
            }
        })
    }
    
    func processCoordinates(coordinates: CLLocationCoordinate2D) {
        let apiURL = "https://congress.api.sunlightfoundation.com"
        let legislatorsURL = apiURL + "/legislators/locate?latitude=" + String(coordinates.latitude) + "&longitude=" + String(coordinates.longitude)
        let url = URL(string: legislatorsURL)
        
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                if let reps = json["results"] as? [[String:Any]] {
                    self.processReps(reps: reps)
                }
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
    
    func processReps(reps: [[String:Any]]) {
        for rep in reps {
            if let firstName = rep["first_name"] as? String {
                if let lastName = rep["last_name"] as? String {
                    let fullName = firstName + " " + lastName
                    print(fullName)
                    repsLabel.text = repsLabel.text! + fullName + "\n"
                    print("repsLabel: " + repsLabel.text!)
                    
                    repsLabel.lineBreakMode = .byWordWrapping
                    repsLabel.numberOfLines = 0
                    
                    self.repsLabel.setNeedsDisplay()
                }
            }
        }
    }
}

