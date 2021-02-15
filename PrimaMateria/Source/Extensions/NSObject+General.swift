//
//  NSObject+General.swift
//  PlaneBalance
//
//  Created by Jerry Porter on 12/6/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Foundation
import SpriteKit
import GameplayKit

public extension NSObject { // General

    class var nameOfClass: String {
        return String(describing: self)
    }

    func double(_ key: String?) -> Double {
        var doubleValue = 0.0

        if let doubleString = value(forKeyPath: key!) as! String? {
            if let doubleNumber = NumberFormatter().number(from: doubleString) {
                doubleValue = doubleNumber.doubleValue
            }
        }

        return doubleValue
    }

    class func toUint(signed: Int) -> UInt {

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
        set {
            text = NSLocalizedString(newValue, comment: "")
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

    func showElementPanelForElement(index: Int, controller: UIViewController) {
        XTRPropertiesStore.viewTitle = title!
        XTRPropertiesStore.atomicNumber = index

        let storyboard = UIStoryboard(name: StoryBoardName.ElementInspector, bundle: nil)
        let elementInspector: XTRElementInspectorViewController = storyboard.instantiateViewController(withIdentifier: XTRElementInspectorViewController.nameOfClass) as! XTRElementInspectorViewController

        elementInspector.modalPresentationStyle = .fullScreen
        elementInspector.modalTransitionStyle = .crossDissolve

       controller.present(elementInspector, animated: XTRPropertiesStore.showTransitionsState, completion: nil)
    }

}

extension SKShader {
    /**
     Convience initializer to create a shader from a filename by way of a string.
     Although this approach is less efficient than loading directly from disk, it enables
     shader errors to be printed in the Xcode console.
     
     - Parameter filename: A filename in your bundle, including extension.
     - Parameter uniforms: An array of SKUniforms to apply to the shader. Defaults to nil.
     - Parameter attributes: An array of SKAttributes to apply to the shader. Defaults to nil.
     */
    convenience init(fromFile filename: String, uniforms: [SKUniform]? = nil, attributes: [SKAttribute]? = nil) {
        // it is a fatal error to attempt to load a missing or corrupted shader
        guard let path = Bundle.main.path(forResource: filename, ofType: "fsh") else {
            fatalError("Unable to find shader \(filename).fsh in bundle")
        }

        guard let source = try? String(contentsOfFile: path) else {
            fatalError("Unable to load shader \(filename).fsh")
        }

        // if we were sent any uniforms then apply them immediately
        if let uniforms = uniforms {
            self.init(source: source as String, uniforms: uniforms)
        } else {
            self.init(source: source as String)
        }

        // if we were sent any attributes then apply those too
        if let attributes = attributes {
            self.attributes = attributes
        }
    }
}

extension SKUniform {
    /**
     Convenience initializer to create an SKUniform from an SKColor.
     - Parameter name: The name of the uniform inside the shader, e.g. u_color.
     - Parameter color: The SKColor to set.
     */
    public convenience init(name: String, color: SKColor) {
        #if os(macOS)
        guard let converted = color.usingColorSpace(.deviceRGB) else {
            fatalError("Attempted to use a color that is not expressible in RGB.")
        }

        let colors = vector_float4([Float(converted.redComponent), Float(converted.greenComponent), Float(converted.blueComponent), Float(converted.alphaComponent)])
        #else
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var alpha: CGFloat = 0

        color.getRed(&r, green: &g, blue: &b, alpha: &alpha)
        let colors = vector_float4([Float(r), Float(g), Float(b), Float(alpha)])
        #endif

        self.init(name: name, vectorFloat4: colors)
    }

    /**
     Convenience initializer to create an SKUniform from a CGSize.
     - Parameter name: The name of the uniform inside the shader, e.g. u_size.
     - Parameter color: The CGSize to set.
     */
    public convenience init(name: String, size: CGSize) {
        let size = vector_float2(Float(size.width), Float(size.height))
        self.init(name: name, vectorFloat2: size)
    }

    /**
     Convenience initializer to create an SKUniform from a CGPoint.
     - Parameter name: The name of the uniform inside the shader, e.g. u_center.
     - Parameter color: The CGPoint to set.
     */
    public convenience init(name: String, point: CGPoint) {
        let point = vector_float2(Float(point.x), Float(point.y))
        self.init(name: name, vectorFloat2: point)
    }
}

protocol XibDesignable: class {}

extension XibDesignable where Self: UIView {

    static func instantiateFromXib() -> Self {

        let dynamicMetatype = Self.self
        let bundle = Bundle(for: dynamicMetatype)
        let nib = UINib(nibName: "\(dynamicMetatype)", bundle: bundle)

        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {

            fatalError("Could not load view from nib file.")
        }
        return view
    }
}

extension UIView: XibDesignable {}

extension UIImageView {

    class func gradientView(frame: CGRect, destinationView: UIView) {
        let imageView = UIImageView(frame: destinationView.bounds)
        imageView.image = UIImage.imageNamed(name: "gradient")
        destinationView.addSubview(imageView)
        destinationView.sendSubviewToBack(imageView)
        destinationView.masksToBounds = false
        destinationView.shadowOffset = CGSize(width: 0, height: -5)
        destinationView.shadowRadius = 5
        destinationView.shadowOpacity = 1
        destinationView.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.53)
        destinationView.addSubview(imageView)
        destinationView.sendSubviewToBack(imageView)
    }
}

extension UIImage {

    class func imageNamed(name: String) -> UIImage {
        guard let image = UIImage(named: name) else { return UIImage() }
        return image
    }

}
