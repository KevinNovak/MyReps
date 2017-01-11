//
//  RepsTableViewController.swift
//  Reps
//
//  Created by Kevin Novak on 1/10/17.
//  Copyright © 2017 Kevin Novak. All rights reserved.
//

import UIKit

class RepsTableViewController: UITableViewController {
    var reps: [[String:Any]] = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // removes empty cells
        tableView.tableFooterView = UIView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    // columns
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reps.count
    }

    // adding cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repCell", for: indexPath) as! RepsTableViewCell

        cell.repImage.image = getRepImage(row: indexPath.row)
        cell.repNameLabel.text = getRepName(row: indexPath.row)
        cell.repTitleLabel.text = getRepTitle(row: indexPath.row)
        
        return cell
    }
    
    // ========================================
    // Get Rep Image
    // ========================================
    func getRepImage(row: Int) -> UIImage {
        // try to get image, otherwise default
        if let image = getRepImageFromAPI(row: row) {
            return image
        } else if let image = getRepImageFromDefault() {
            return image
        }
        
        // if default image fails, return new instance
        return UIImage()
    }
    
    func getRepImageFromAPI(row: Int) -> UIImage? {
        if let bioGuideID = reps[row]["bioguide_id"] as? String {
            let repImageURLString = "https://raw.githubusercontent.com/unitedstates/images/gh-pages/congress/225x275/" + bioGuideID + ".jpg"
            let repImageURL = URL(string: repImageURLString)
            if let data = try? Data(contentsOf: repImageURL!) {
                if let image = UIImage(data: data) {
                    return image
                }
            }
        }
        return nil
    }
    
    func getRepImageFromDefault() -> UIImage? {
        if let image = UIImage(named:"default_rep_image.png") {
            return image
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
     // ========================================
    // Get Rep Name
    // ========================================
    func getRepName(row: Int) -> String {
        if let firstName = reps[row]["first_name"] as? String {
            if let lastName = reps[row]["last_name"] as? String {
                let fullName = firstName + " " + lastName
                return fullName
            }
        }
        return "Unknown"
    }
    
    // ========================================
    // Get Rep Title
    // ========================================
    func getRepTitle(row: Int) -> String {
        var fullTitle = "Unknown"
        
        let chamber = getRepChamber(row: row)
        let state = getRepState(row: row)
        let party = getRepParty(row: row)
        
        if (chamber == "Senator") {
            fullTitle = state + " "
            fullTitle += chamber + " ("
            fullTitle += party + ")"
        } else if (chamber == "Rep.") {
            let district = getRepDistrict(row: row)
            let districtPostFix = getNumPostFix(row: district)
            fullTitle = chamber + " of "
            fullTitle += state + "'s "
            fullTitle += String(district)
            fullTitle += districtPostFix + " District ("
            fullTitle += party + ")"
        }
        
        return fullTitle
    }
    
    func getRepChamber(row: Int) -> String {
        var chamberString = "Unknown"
        if let chamber = reps[row]["chamber"] as? String {
            if (chamber == "senate") {
                chamberString = "Senator"
            } else if (chamber == "house") {
                chamberString = "Rep."
            }
        }
        return chamberString
    }
    
    func getRepState(row: Int) -> String {
        var stateString = "Unknown"
        if let state = reps[row]["state_name"] as? String {
            stateString = state
        }
        return stateString
    }
    
    func getRepParty(row: Int) -> String {
        var partyString = "U"
        if let party = reps[row]["party"] as? String {
            partyString = party
        }
        return partyString
    }
    
    func getRepDistrict(row: Int) -> Int {
        var districtInt = -1
        if let district = reps[row]["district"] as? Int {
            districtInt = district
        }
        return districtInt
    }
    
    func getNumPostFix(row: Int) -> String {
        var numPostFix = "th"
        if (row == 1) {
            numPostFix = "st"
        } else if (row == 2) {
            numPostFix = "nd"
        } else if (row == 3) {
            numPostFix = "rd"
        }
        return numPostFix
    }
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
