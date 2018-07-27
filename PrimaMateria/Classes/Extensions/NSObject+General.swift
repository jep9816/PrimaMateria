//
//  NSObject+General.swift
//  PlaneBalance
//
//  Created by Jerry Porter on 12/6/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public extension NSObject { // General
    
    public class var nameOfClass: String {
        return String(describing: self)
    }
    
    public func double(_ key: String?) -> Double {
        var doubleValue = 0.0
        
        if let doubleString = value(forKeyPath: key!) as! String? {
            if let doubleNumber = NumberFormatter().number(from: doubleString) {
                doubleValue = doubleNumber.doubleValue
            }
        }
        
        return doubleValue
    }
    
    public class func toUint(signed: Int) -> UInt {
        
        let unsigned = signed >= 0 ?
            UInt(signed) :
            UInt(signed  - Int.min) + UInt(Int.max) + 1
        
        return unsigned
    }
    
    func mapToObserver(button: UIButton) -> Observable<UIButton> {
        return button.rx.tap.map { _ in return button}
    }
    
}

extension UILabel {
    
    var localizedText: String {
        set (key) {
            text = NSLocalizedString(key, comment: "")
        }
        get {
            return text!
        }
    }
    
}

extension String {
    
    func image(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    func lowercasingFirstLetter() -> String {
        return prefix(1).lowercased() + dropFirst()
    }
    
    var camelCasedString: String {
        return self.components(separatedBy: " ")
            .map { return $0.lowercased().capitalizingFirstLetter() }
            .joined()
    }
    
}

extension UIViewController {
    
    func showElementPanelForElementAtIndex(index: Int) {
        XTRPropertiesStore.viewTitle = title!
        XTRPropertiesStore.atomicNumber = index
        
        let storyboard = UIStoryboard(name: ELEMENT_INSPECTOR_STORY_BOARD, bundle: nil)
        let elementInspector: XTRElementInspectorViewController = storyboard.instantiateViewController(withIdentifier: XTRElementInspectorViewController.nameOfClass) as! XTRElementInspectorViewController
        
        elementInspector.modalPresentationStyle = .fullScreen
        elementInspector.modalTransitionStyle = .crossDissolve
        
        present(elementInspector, animated: true, completion: nil)
    }
    
}
