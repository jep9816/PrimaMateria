//
//  XTRGraphChoiceCell.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/1/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

class XTRGraphChoiceCell: UICollectionViewCell {
    
    @IBOutlet var button: XTRGeneralButton!
    
    @IBAction func chooseGraph(_ sender: UIButton) {
        NotificationCenter.default.post(name: .graphSelectedNotification, object: sender.tag)
    }
    
    func setup(index: Int) {
        let dict = XTRDataSource.sharedInstance().graphPropertyList!.value[index]
        let titleKey = dict[GraphAttribute.title] as? String
        let title = NSLocalizedString(titleKey!, comment: "")
        
        button.addTarget(self, action: #selector(chooseGraph(_:)), for: .touchUpInside)
        button.setTitle(title, for: .normal)
        button.setTitle(title, for: .highlighted)
        button.showsTouchWhenHighlighted = false
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.tag = index
    }
    
}
