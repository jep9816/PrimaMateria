//
//  XTRCornerImageView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import UIKit

class XTRCornerImageView: UIImageView {

    private var gradientLayer: CAGradientLayer!

    // MARK: - Initialization Methods

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        createLayer()
    }

    // MARK: - Internal Methods

    func createLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.bounds = bounds
        gradientLayer.position = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        layer.insertSublayer(gradientLayer, at: 0)
        cornerRadius = VIEW_CORNER_RADIUS
        masksToBounds = true
    }

}
