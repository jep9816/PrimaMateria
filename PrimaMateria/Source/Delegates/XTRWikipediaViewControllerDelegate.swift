//
//  XTRWikipediaViewControllerDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/21/18.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import WebKit
//import MBProgressHUD

class XTRWikipediaViewControllerDelegate: NSObject, WKNavigationDelegate {
    
    weak var controller: XTRWikipediaViewController?
    
    // MARK: - WebView Delegate Methods
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        guard let controller = controller else { return }

        //MBProgressHUD.showAdded(to: controller.view, animated: true)

        controller.backButton.isEnabled = false
        controller.forwardButton.isEnabled = false
        controller.backButton.tintColor = UIColor.black
        controller.forwardButton.tintColor = UIColor.black
    }
    
    public func webView(_ aWebView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let controller = controller else { return }
        
        //MBProgressHUD.hide(for: controller.view, animated: true)

        if aWebView.canGoBack {
            controller.backButton.isEnabled = true
            controller.backButton.tintColor = UIColor.white
        } else if !aWebView.canGoBack {
            controller.backButton.isEnabled = false
            controller.backButton.tintColor = UIColor.black
        }
        
        if aWebView.canGoForward {
            controller.forwardButton.isEnabled = true
            controller.forwardButton.tintColor = UIColor.white
        } else if !aWebView.canGoForward {
            controller.forwardButton.isEnabled = false
            controller.forwardButton.tintColor = UIColor.black
        }
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        guard let path = Bundle.main.path(forResource: "LoadFailure", ofType: FileType.html, inDirectory: "\(XTRPropertiesStore.currentLanguageCode).lproj") else { return }
        //guard let controller = controller else { return }

        //MBProgressHUD.hide(for: controller.view, animated: true)
        controller?.progressHUD.show(animated: XTRPropertiesStore.showTransitionsState)

        if !path.isEmpty {
            webView.load(URLRequest(url: URL(fileURLWithPath: path)))
        }
    }
    
}
