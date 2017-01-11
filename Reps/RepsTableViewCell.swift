//
//  RepsTableViewCell.swift
//  Reps
//
//  Created by Kevin Novak on 1/10/17.
//  Copyright © 2017 Kevin Novak. All rights reserved.
//

import UIKit

class RepsTableViewCell: UITableViewCell {
//    @IBOutlet weak var repImage: UIImageView!
    @IBOutlet weak var repImage: UIImageView!
    @IBOutlet weak var repNameLabel: UILabel!
    @IBOutlet weak var repTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
