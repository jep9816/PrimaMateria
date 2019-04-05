//
//  XTRPageControl.swift
//  PrimaMateria
//
//  Created by Developer2 on 7/13/18.
//  Copyright © 2019 xTrensa. All rights reserved.
//

import UIKit

class XTRProgressView: UIProgressView {
    
    var height: CGFloat = 14.0
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let size: CGSize = CGSize(width: self.frame.size.width, height: height)
        
        return size
    }
    
}

class XTRPageControl: UIView {
    
    var nextLabel: UILabel!
    var previousLabel: UILabel!
    var wrapperView: UIView!
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func populateRightLabel(name: String) {
        nextLabel.text = "\(NSLocalizedString("swipeRight", comment: "")) \(name)"
    }
    
    func populateLeftLabel(name: String) {
        previousLabel.text = "\(NSLocalizedString("swipeLeft", comment: "")) \(name)"
    }
    
    func updatePreviousLabel(atomicNumber: Int) {
        let index = atomicNumber - 1
        if index >= 0 {
            let imageView = wrapperView.subviews[atomicNumber - 1] as! UIImageView
            imageView.image = UIImage(named: "dotOpen")
        }
    }
    
    func updateNextLabel(atomicNumber: Int) {
        if atomicNumber <= XTRDataSource.sharedInstance.elementCount() {
            let imageView = wrapperView.subviews[atomicNumber - 1] as! UIImageView
            imageView.image = UIImage(named: "dotOpen")
        }
    }
    
    func updateCurrentLabel(atomicNumber: Int) {
        let imageView = wrapperView.subviews[atomicNumber - 1] as! UIImageView
        imageView.image = UIImage(named: "dotClosed")
    }
    
    private func createLabel(frame: CGRect) -> UILabel {
        let label = UILabel(frame: frame)
        label.font = UIFont.systemFont(ofSize: 16)
        label.backgroundColor = XTRColorFactory.transparentColor
        label.textColor = UIColor.yellow // XTRColorFactory.pageControlLabelColor
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.borderColor = XTRColorFactoryClassic.interactiveBlue
        label.borderWidth = 1
        label.cornerRadius = 6
        
        return label
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        var rect = CGRect(x: 10, y: 30, width: 8, height: 8)
        let count = XTRDataSource.sharedInstance.elementCount() - 1
        wrapperView = UIView(frame: bounds)
        
        for _ in 0...count {
            let imageView = UIImageView(frame: rect)
            imageView.image = UIImage(named: "dotOpen")
            wrapperView.addSubview(imageView)
            rect = CGRect(x: imageView.frame.origin.x + 8.5, y: 30, width: 8, height: 8)
        }
        
        addSubview(wrapperView)

        previousLabel = createLabel(frame: CGRect(x: 10, y: 4, width: 400, height: 25))
        addSubview(previousLabel)
        
        nextLabel = createLabel(frame: CGRect(x: 613, y: 4, width: 400, height: 25))
        addSubview(nextLabel)
        
        UIImageView.gradientView(frame: bounds, destinationView: self)
    }
}
