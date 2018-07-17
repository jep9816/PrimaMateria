//
//  XTRHelpBalloonViewControllerDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/21/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import WebKit

class XTRHelpBalloonViewControllerDelegate: NSObject, WKUIDelegate, WKNavigationDelegate {

    weak var controller: XTRHelpBalloonViewController?

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        controller?.backButton.isEnabled = false
        controller?.forwardButton.isEnabled = false
        controller?.backButton.tintColor = UIColor.black
        controller?.forwardButton.tintColor = UIColor.black
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView.canGoBack {
            controller?.backButton.isEnabled = true
            controller?.backButton.tintColor = UIColor.white
        } else if !webView.canGoBack {
            controller?.backButton.isEnabled = false
            controller?.backButton.tintColor = UIColor.black
        }
        
        if webView.canGoForward {
            controller?.forwardButton.isEnabled = true
            controller?.forwardButton.tintColor = UIColor.white
        } else if !webView.canGoForward {
            controller?.forwardButton.isEnabled = false
            controller?.forwardButton.tintColor = UIColor.black
        }
    }
    
}
