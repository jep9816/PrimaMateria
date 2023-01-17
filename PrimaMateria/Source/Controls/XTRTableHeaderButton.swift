//
//  XTRTableHeaderButton.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/14/16.
//  Copyright ©2023 xTrensa. All rights reserved.
//

import UIKit

class XTRTableHeaderButton: XTRGeneralButton {

    var imageLayer: CALayer
    var descendingImage: UIImage
    var ascendingImage: UIImage
    var toggle: Bool = false

    // MARK: - Initialization Methods

    required init?(coder aDecoder: NSCoder) {
        ascendingImage = XTRImageFactory.ascendingArrowImage
        descendingImage = XTRImageFactory.descendingArrowImage
        imageLayer = CALayer()

        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        NotificationCenter.default.addObserver(self, selector: #selector(tableHeaderCellSelected(_:)), name: .tableHeaderCellSelectedNotification, object: nil)

        layer.addSublayer(imageLayer)
    }

    // MARK: - Notification Methods

    @objc func tableHeaderCellSelected(_ aNotification: Notification) {
        imageLayer.contents = nil
    }

    // MARK: - Internal Methods

    func toggleButtonState(_ aFlag: Bool) {
        NotificationCenter.default.post(name: .tableHeaderCellSelectedNotification, object: nil)
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.0)
        let origin = (aFlag) ? CGPoint(x: (frame.size.width / 2) - 6, y: 4) : CGPoint(x: (frame.size.width / 2) - 6, y: 30)
        imageLayer.frame = CGRect(origin: origin, size: CGSize(width: 12, height: 12))
        imageLayer.contents = (aFlag) ? ascendingImage.cgImage : descendingImage.cgImage
        CATransaction.commit()
        toggle = aFlag
    }

    func toggleState() -> Bool {
        toggleButtonState(!toggle)
        return toggle
    }

    override func createLayer() {
        masksToBounds = true
        borderWidth = 1.0
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
