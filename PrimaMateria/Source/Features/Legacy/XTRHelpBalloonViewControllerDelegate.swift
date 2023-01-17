//
//  XTRHelpBalloonViewControllerDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/21/18.
//  Copyright ©2023 xTrensa. All rights reserved.
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

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {

        // Scale the page to fill the web view
        let viewportScriptString = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); meta.setAttribute('initial-scale', '1.0'); meta.setAttribute('maximum-scale', '1.0'); meta.setAttribute('minimum-scale', '1.0'); meta.setAttribute('user-scalable', 'no'); document.getElementsByTagName('head')[0].appendChild(meta);"
         let viewportScript = WKUserScript(source: viewportScriptString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
         let controller = WKUserContentController()
         let config = WKWebViewConfiguration()

         controller.addUserScript(viewportScript)
         config.userContentController = controller

        return WKWebView(frame: webView.frame, configuration: config)
    }

}
