//
//  XTRZoomContentView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/31/18.
//  Copyright ©2023 xTrensa. All rights reserved.
//

import UIKit

class XTRZoomContentView: UIView {
    @IBOutlet var label: UILabel!
    @IBOutlet var wrapper: UIView!
    @IBOutlet var content: UIView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = UIColor.clear.withAlphaComponent(0.0)

        shadowOffset = CGSize(width: 8.0, height: 8.0)
        shadowColor = UIColor.black
        shadowRadius = 8.0
        shadowOpacity = 0.5
        masksToBounds = false

        wrapper.borderColor = UIColor.white
        wrapper.borderWidth = 3.0
        wrapper.cornerRadius = VIEW_CORNER_RADIUS
        wrapper.masksToBounds = true
        wrapper.backgroundColor = UIColor.clear.withAlphaComponent(0.0)
        wrapper.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        wrapper.translatesAutoresizingMaskIntoConstraints = true

        label.textAlignment = .center
        label.font = XTRFontFactory.systemFont20

        if XTRAppearanceManager.manager.isClassicAppearance() {
            label.textColor = XTRColorFactoryClassic.white
            label.backgroundColor = XTRColorFactoryClassic.inkwell
        } else {
            label.textColor = XTRColorFactoryStandard.ghost
            label.backgroundColor = XTRColorFactoryStandard.standardRedColor
            label.shadowColor = XTRColorFactoryStandard.darkText
            label.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
            label.shadowRadius = 3.0
            label.shadowOpacity = 1.0
            label.masksToBounds = false
        }

        label.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin]
        label.translatesAutoresizingMaskIntoConstraints = true
        label.borderColor = XTRAppearanceManager.manager.isClassicAppearance() ? XTRColorFactoryClassic.white : XTRColorFactoryStandard.ghost
        label.borderWidth = 2.0
    }

    func addContent(_ view: UIView) {
        wrapper.addSubview(view)

        view.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 0.7)
        view.isUserInteractionEnabled = true
    }

    var title: String {
        get { return label.text! }
        set { label.text = newValue }
    }

}
