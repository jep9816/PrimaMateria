//
//  XTRProgressHUD.swift
//  PrimaMateria PRD
//
//  Created by Jerry Porter on 8/21/18.
//  Copyright © 2018 Jerry Porter. All rights reserved.
//

@objc protocol XTRProgressHUDDelegate: MBProgressHUDDelegate {

}

class XTRProgressHUD: MBProgressHUD {
    
//    class func showHUDAddedTo(view: UIView, animated: Bool) -> XTRProgressHUD {
//        let hud: XTRProgressHUD = XTRProgressHUD()
//        hud.removeFromSuperViewOnHide = true
//        view.addSubview(hud)
//        hud.show(animated: animated)
//        return hud
//    }
//    
//    class func hideHUDForView(view: UIView, animated: Bool) -> Bool {
//        let hud: XTRProgressHUD! = XTRProgressHUD(view: view)
//        if hud != nil {
//            hud.removeFromSuperview()
//            hud.hide(animated: animated)
//            return true
//        }
//        return false
//    }
//
//    class func hideHUDForView(view: UIView) -> XTRProgressHUD {
//        let hud: XTRProgressHUD! = XTRProgressHUD(view: view)
//        if hud != nil {
//            hud.removeFromSuperview()
//            hud.hide(animated: animated)
//            return true
//        }
//        return false
//    }

    /*+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated {
     MBProgressHUD *hud = [self HUDForView:view];
     if (hud != nil) {
     hud.removeFromSuperViewOnHide = YES;
     [hud hideAnimated:animated];
     return YES;
     }
     return NO;
     }

     + (MBProgressHUD *)HUDForView:(UIView *)view {
     NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
     for (UIView *subview in subviewsEnum) {
     if ([subview isKindOfClass:self]) {
     MBProgressHUD *hud = (MBProgressHUD *)subview;
     if (hud.hasFinished == NO) {
     return hud;
     }
     }
     }
     return nil;
     }

*/
}
