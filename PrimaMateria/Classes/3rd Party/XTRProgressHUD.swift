//
//  XTRProgressHUD.swift
//  PrimaMateria PRD
//
//  Created by Jerry Porter on 8/21/18.
//  Copyright © 2018 Jerry Porter. All rights reserved.
//

@objc protocol XTRProgressHUDDelegate: MBProgressHUDDelegate {
    
}

//#define MBMainThreadAssert() NSAssert([NSThread isMainThread], @"MBProgressHUD needs to be accessed on the main thread.");
//typedef void (^MBProgressHUDCompletionBlock)(void);

let kCFCoreFoundationVersionNumber_iOS_8_0: Float = 1129.15
let MBProgressMaxOffset: Float = 1000000.0

let MBDefaultPadding: Float = 4.0
let MBDefaultLabelFontSize: Float = 16.0
let MBDefaultDetailsLabelFontSize: Float = 12.0

enum MBProgressHUDMode: Int {
    case indeterminate
    /// A round, pie-chart like, progress view.
    case determinate
    /// Horizontal progress bar.
    case determinateHorizontalBar
    /// Ring-shaped progress view.
    case annularDeterminate
    /// Shows a custom view.
    case customView
    /// Shows only labels.
    case text
}

enum MBProgressHUDAnimation: Int {
    /// Opacity animation
    case fade
    /// Opacity + scale animation (zoom in when appearing zoom out when disappearing)
    case zoom
    /// Opacity + scale animation (zoom out style)
    case zoomOut
    /// Opacity + scale animation (zoom in style)
    case zoomIn
}

enum MBProgressHUDBackgroundStyle: Int {
    /// Solid color background
    case solidColor
    /// UIVisualEffectView or UIToolbar.layer background view
    case blur
}

class XTRProgressHUD: MBProgressHUD {
    
    var useAnimation: Bool = false
    var finished: Bool = false
    var indicator: UIView!
    var showStarted: Date!
    var paddingConstraints: NSMutableArray!
    var bezelConstraints: NSMutableArray!
    var topSpacer: UIView!
    var bottomSpacer: UIView!
    var graceTimer: Timer!
    var minShowTimer: Timer!
    var hideDelayTimer: Timer!
    var progressObjectDisplayLink: CADisplayLink!
    
    convenience init() {
        self.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(view: UIView) {
        super.init(view: view)
    }
    
    var hasFinished: Bool {
        get { return finished }
        set { finished = newValue }
    }
    
    class func showHUDAddedTo(view: UIView, animated: Bool) -> XTRProgressHUD {
        let hud: XTRProgressHUD = XTRProgressHUD()
        hud.removeFromSuperViewOnHide = true
        view.addSubview(hud)
        hud.show(animated: animated)
        return hud
    }
    
    class func hideHUDForView(view: UIView, animated: Bool) -> Bool {
        let hud: XTRProgressHUD! = XTRProgressHUD(view: view)
        if hud != nil {
            hud.removeFromSuperview()
            hud.hide(animated: animated)
            return true
        }
        return false
    }
    
    // swiftlint:disable for_where
    class func HUDForView(view: UIView) -> XTRProgressHUD? {
        let subviewsEnum = view.subviews.reversed()
        
        for subview in subviewsEnum {
            if subview is XTRProgressHUD {
                let hud: XTRProgressHUD = subview as! XTRProgressHUD
                
                if hud.hasFinished == false {
                    return hud
                }
            }
        }
        return nil
    }
    
}
