//
//  RepsTableViewCell.swift
//  Reps
//
//  Created by Kevin Novak on 1/10/17.
//  Copyright © 2017 Kevin Novak. All rights reserved.
//

import UIKit

class RepsTableViewCell: UITableViewCell {
    var isObserving = false;

    @IBOutlet weak var repImage: UIImageView!
    @IBOutlet weak var repNameLabel: UILabel!
    @IBOutlet weak var repTitleLabel: UILabel!
    @IBOutlet weak var expandedView: UIView!
    @IBOutlet weak var repTermLabel: UILabel!
    
    class var expandedHeight: CGFloat { get { return 200 } }
    class var closedHeight: CGFloat  { get { return 60  } }
    
    func checkHeight() {
        expandedView.isHidden = (frame.size.height < RepsTableViewCell.expandedHeight)
    }
    
    func watchFrameChanges() {
        if !isObserving {
            addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.initial], context: nil)
            isObserving = true;
        }
    }
    
    func ignoreFrameChanges() {
        if isObserving {
            removeObserver(self, forKeyPath: "frame")
            isObserving = false;
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
}
