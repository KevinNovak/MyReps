//
//  AddressViewController.swift
//  Reps
//
//  Created by Kevin Novak on 1/10/17.
//  Copyright © 2017 Kevin Novak. All rights reserved.
//

import UIKit
import CoreLocation

class AddressViewController: UIViewController {
    let geocoder = CLGeocoder()
    var reps: [[String:Any]] = [[String:Any]]()
    
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func submitAddressButtonPressed(_ sender: Any) {
        print("Submitted Address Field: " + addressField.text!)
        
        DispatchQueue.main.async() {
            self.errorLabel.isHidden = true
        }
        
        self.processAddress(address: self.addressField.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async() {
            self.errorLabel.isHidden = true
        }
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        self.navigationItem.backBarButtonItem = backItem
    }
    
    func processResult(success: Bool) {
        if (success) {
            print("Address valid, found representatives")
            let repsVC = self.storyboard?.instantiateViewController(withIdentifier: "RepsTableViewController") as! RepsTableViewController
            repsVC.reps = self.reps
            repsVC.navigationItem.title = "Representatives"
            DispatchQueue.main.async(){
                self.navigationController?.pushViewController(repsVC, animated: true)
            }
        } else {
            print("Address does not contain any representatives")
            DispatchQueue.main.async() {
                self.errorLabel.isHidden = false
            }
        }
    }
    
    func processAddress(address: String) {
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("ERROR: Geocoding string error")
                self.processResult(success: false)
                return
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                self.processCoordinates(coordinates: coordinates)
                return
            } else {
                print("ERROR: Could not convert address string to placemark/coordinates")
                self.processResult(success: false)
                return
            }
        })
    }
    
    func processCoordinates(coordinates: CLLocationCoordinate2D) {
        let apiURL = "https://congress.api.sunlightfoundation.com"
        let legislatorsURL = apiURL + "/legislators/locate?latitude=" + String(coordinates.latitude) + "&longitude=" + String(coordinates.longitude)
        let url = URL(string: legislatorsURL)
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else {
                print("ERROR: Could not verify API response")
                self.processResult(success: false)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                if let reps = json["results"] as? [[String:Any]] {
                    self.processReps(reps: reps)
                } else {
                    print("ERROR: Could not convert JSON results to dictionary")
                    self.processResult(success: false)
                    return
                }
            } catch let error as NSError {
                print(error)
                self.processResult(success: false)
                return
            }
        }).resume()
    }
    
    func processReps(reps: [[String:Any]]) {
        if (reps.count > 0) {
            if (reps.first?["first_name"] != nil) {
                self.reps = reps
                self.processResult(success: true)
                return
            } else {
                print("ERROR: Could not find a first name for first representative")
                self.processResult(success: false)
                return
            }
        } else {
            print("ERROR: Could not find any representatives")
            self.processResult(success: false)
            return
        }
    }
}
