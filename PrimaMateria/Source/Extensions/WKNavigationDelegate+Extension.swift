//
//  WKNavigationDelegate+Extension.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/18/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import WebKit

extension XTRWebViewWrapper.Coordinator: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if action == nil {
            decisionHandler(.allow)
        } else {
            action?(.decidePolicy(navigationAction, decisionHandler))
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        webViewStateModel.loading = true
        
        action?(.didStartProvisionalNavigation(navigation))
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        action?(.didReceiveServerRedirectForProvisionalNavigation(navigation))
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        webViewStateModel.loading = false
        webViewStateModel.canGoBack = webView.canGoBack
        webViewStateModel.canGoForward = webView.canGoForward
        
        action?(.didFailProvisionalNavigation(navigation, error))
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        action?(.didCommit(navigation))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webViewStateModel.loading = false
        webViewStateModel.canGoBack = webView.canGoBack
        webViewStateModel.canGoForward = webView.canGoForward
        
        if let title = webView.title {
            webViewStateModel.pageTitle = title
        }
        
        action?(.didFinish(navigation))
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        webViewStateModel.loading = false
        webViewStateModel.canGoBack = webView.canGoBack
        webViewStateModel.canGoForward = webView.canGoForward
        
        action?(.didFail(navigation, error))
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if action == nil {
            completionHandler(.performDefaultHandling, nil)
        } else {
            action?(.didRecieveAuthChallange(challenge, completionHandler))
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
