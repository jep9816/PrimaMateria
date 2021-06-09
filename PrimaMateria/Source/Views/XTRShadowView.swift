//
//  XTRShadowView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import Foundation
import UIKit

class XTRShadowView: UIImageView {

    // MARK: - Initialization Methods

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    init(frame: CGRect, view: UIView) {
        super.init(frame: frame)
        createLayer(frame: frame, superView: view)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        createLayer(frame: CGRect(x: frame.origin.x + 1, y: frame.origin.y + 1, width: frame.size.width - 2, height: frame.size.height - 2), superView: nil)
    }

    // MARK: - Internal Methods

    func createLayer(frame: CGRect, superView: UIView?) {
        var tempSuperView: UIView
        let sublayer = CALayer()

        if superView == nil {
            tempSuperView = superview!
        } else {
            tempSuperView = superView!
        }

        sublayer.backgroundColor = UIColor.clear.cgColor
        sublayer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        sublayer.shadowRadius = 10.0
        sublayer.shadowColor = UIColor.black.cgColor
        sublayer.shadowOpacity = 1.0
        sublayer.frame = frame
        sublayer.borderColor = UIColor.black.cgColor
        sublayer.backgroundColor = UIColor.black.cgColor
        sublayer.borderWidth = 1.0
        sublayer.cornerRadius = VIEW_CORNER_RADIUS

        tempSuperView.layer.addSublayer(sublayer)

        masksToBounds = true
        cornerRadius = VIEW_CORNER_RADIUS
        borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        borderWidth = 3.0
        isOpaque = false

        tempSuperView.bringSubviewToFront(self)
    }

}
