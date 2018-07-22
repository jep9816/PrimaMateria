//
//  XTRPageControl.swift
//  PrimaMateria
//
//  Created by Developer2 on 7/13/18.
//  Copyright © 2018 Jerry Porter. All rights reserved.
//

import UIKit

class XTRPageControl: UIView {
    
    var nextLabel: UILabel!
    var previousLabel: UILabel!
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func populateRightLabel(name: String) {
        nextLabel.text = " \(NSLocalizedString("swipeRight", comment: "")) \(name)"
    }
    
    func populateLeftLabel(name: String) {
        previousLabel.text = " \(NSLocalizedString("swipeLeft", comment: "")) \(name)"
    }
    
    func updatePreviousLabel(atomicNumber: Int) {
        let label = subviews[atomicNumber + 1] as! UILabel
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.textColor = XTRColorFactory.pageIndicatorTintColor
    }
    
    func updateNextLabel(atomicNumber: Int) {
        let label = subviews[atomicNumber + 1] as! UILabel
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.textColor = XTRColorFactory.pageIndicatorTintColor
    }
    
    func updateCurrentLabel(atomicNumber: Int) {
        let currentLabel = subviews[atomicNumber + 1] as! UILabel
        currentLabel.font = UIFont.systemFont(ofSize: 10.0)
        currentLabel.textColor = XTRColorFactory.currentPageIndicatorTintColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        var rect = CGRect(x: 12, y: 30, width: 8, height: 8)
        let count = XTRDataSource.sharedInstance.elementCount() - 1
        
        for _ in 0...count {
            let label = UILabel(frame: rect)
            label.text = "●"
            label.textAlignment = .center
            label.numberOfLines = 1
            label.font = UIFont.systemFont(ofSize: 10.0)
            label.textColor = XTRColorFactory.pageIndicatorTintColor
            label.backgroundColor = XTRColorFactory.transparentColor
            addSubview(label)
            rect = CGRect(x: label.frame.origin.x + 8.5, y: 30, width: 8, height: 8)
        }
        
        previousLabel = UILabel(frame: CGRect(x: 5, y: 6, width: 400, height: 25))
        previousLabel.font = UIFont.systemFont(ofSize: 16)
        previousLabel.backgroundColor = XTRColorFactory.transparentColor
        previousLabel.textColor = XTRColorFactory.pageControlLabelColor
        previousLabel.textAlignment = .left
        addSubview(previousLabel)
        
        nextLabel = UILabel(frame: CGRect(x: 615, y: 6, width: 400, height: 25))
        nextLabel.font = UIFont.systemFont(ofSize: 16)
        nextLabel.backgroundColor = XTRColorFactory.transparentColor
        nextLabel.textColor = XTRColorFactory.pageControlLabelColor
        nextLabel.textAlignment = .right
        addSubview(nextLabel)
    }
}
