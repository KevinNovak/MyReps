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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reps.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repCell", for: indexPath) as! RepsTableViewCell

        if let firstName = reps[indexPath.row]["first_name"] as? String {
            if let lastName = reps[indexPath.row]["last_name"] as? String {
                let fullName = firstName + " " + lastName
                cell.repNameLabel.text = fullName
                
                cell.repImage.image = UIImage(named:"default_rep_image.png")
                
                if let bioGuideID = reps[indexPath.row]["bioguide_id"] as? String {
                    let repImageURLString = "https://raw.githubusercontent.com/unitedstates/images/gh-pages/congress/225x275/" + bioGuideID + ".jpg"
                    let repImageURL = URL(string: repImageURLString)
                    if let data = try? Data(contentsOf: repImageURL!) {
                        if let image = UIImage(data: data) {
                            cell.repImage.image = image
                        }
                    }
                }
            }
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
