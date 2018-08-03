//
//  XTRZoomContentView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/31/18.
//  Copyright © 2018 Jerry Porter. All rights reserved.
//

import UIKit

struct XTRZoomContentViewConfig {
    static let viewHeight = 716.0
    static let viewWidth = 716.0
}

class XTRZoomContentView: UIView {
    var label: UILabel!
    var wrapper: UIView!
    var content: UIView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(frame: CGRect, title: String, gesture: UITapGestureRecognizer?) {
        super.init(frame: frame)
        
        wrapper = UIView(frame: CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height))
        label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: XTRZoomContentViewConfig.viewWidth, height: 32.0))
        //addGestureRecognizer(gesture!)
        
        backgroundColor = UIColor.clear.withAlphaComponent(0.0)
        layer.shadowOffset = CGSize(width: 8.0, height: 8.0)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        isUserInteractionEnabled = true

        wrapper.borderColor = UIColor.white
        wrapper.borderWidth = 3.0
        wrapper.cornerRadius = VIEW_CORNER_RADIUS
        wrapper.masksToBounds = true
        wrapper.backgroundColor = UIColor.clear.withAlphaComponent(0.0)
        wrapper.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        wrapper.translatesAutoresizingMaskIntoConstraints = true
        wrapper.isUserInteractionEnabled = true

        label.text = title
        label.textColor = XTRColorFactoryClassic.white
        label.backgroundColor = XTRColorFactoryClassic.inkwell
        label.tintColor = XTRColorFactoryClassic.galleryColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.isEnabled = false
        label.shadowOffset = CGSize(width: 5.0, height: 5.0)
        label.shadowColor = UIColor.lightGray
        label.shadowRadius = 5.0
        label.shadowOpacity = 0.5
        label.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin]
        label.translatesAutoresizingMaskIntoConstraints = true
        label.borderColor = UIColor.white
        label.borderWidth = 2.0

        addSubview(wrapper)
        wrapper.addSubview(label)
    }
    
    func addContent(_ view: UIView) {
        wrapper.addSubview(view)
        view.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 0.7)
        view.isUserInteractionEnabled = true

//        let button = UIButton(type: .infoLight)
//        button.addTarget(self, action: #selector(doIt(sender:)), for: .touchUpInside)
//        button.frame = CGRect(x: 5, y: 5, width: 48, height: 48)
//        view.addSubview(button)
    }
    
    @objc func doIt(sender: Any?) {
        print("doit tapped")
    }

}
