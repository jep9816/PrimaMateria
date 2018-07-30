//
//  XTRWikipediaViewControllerDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/21/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import WebKit

class XTRWikipediaViewControllerDelegate: NSObject, WKNavigationDelegate, MBProgressHUDDelegate {

    weak var controller: XTRWikipediaViewController?

    // MARK: - WebView Delegate Methods
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        controller?.progressHUD.show(animated: XTRPropertiesStore.showTransitionsState)
        controller?.backButton.isEnabled = false
        controller?.forwardButton.isEnabled = false
        controller?.backButton.tintColor = UIColor.black
        controller?.forwardButton.tintColor = UIColor.black
    }
    
    public func webView(_ aWebView: WKWebView, didFinish navigation: WKNavigation!) {
        MBProgressHUD.hide(for: (controller?.view)!, animated: XTRPropertiesStore.showTransitionsState)
        
        if aWebView.canGoBack {
            controller?.backButton.isEnabled = true
            controller?.backButton.tintColor = UIColor.white
        } else if !aWebView.canGoBack {
            controller?.backButton.isEnabled = false
            controller?.backButton.tintColor = UIColor.black
        }
        
        if aWebView.canGoForward {
            controller?.forwardButton.isEnabled = true
            controller?.forwardButton.tintColor = UIColor.white
        } else if !aWebView.canGoForward {
            controller?.forwardButton.isEnabled = false
            controller?.forwardButton.tintColor = UIColor.black
        }
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let path = Bundle.main.path(forResource: "LoadFailure", ofType: FileType.html)!
        
        MBProgressHUD.hide(for: (controller?.view)!, animated: XTRPropertiesStore.showTransitionsState)
        
        webView.load(URLRequest(url: URL(fileURLWithPath: path)))
    }
    
    // MARK: - MBProgressHUDDelegate methods
    
    func hudWasHidden(_ aProgressHUD: MBProgressHUD) {
        aProgressHUD.removeFromSuperview()
    }
    
}
