//
//  XTRBackgroundView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/24/18.
//  Copyright ©2020 xTrensa. All rights reserved.
//

import UIKit

class XTRBackgroundView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(changeAppearance(notification:)), name: .notificationAppearanceChanged, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .notificationAppearanceChanged, object: nil)
    }

}

extension XTRBackgroundView {
    
    @objc func changeAppearance(notification: NSNotification) {
        backgroundColor = XTRColorFactory.backgroundColor
    }
    
}
