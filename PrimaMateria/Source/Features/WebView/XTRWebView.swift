//
//  WebView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/18/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import SwiftUI
import WebKit

struct XTRWebViewConfig {
    static let barButtonSize = CGSize(width: 44, height: 44)
}

struct XTRWebView: View {
    
    enum NavigationAction {
        case decidePolicy(WKNavigationAction, (WKNavigationActionPolicy) -> Void) //mendetory
        case didRecieveAuthChallange(URLAuthenticationChallenge, (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) //mandatory
        case didStartProvisionalNavigation(WKNavigation)
        case didReceiveServerRedirectForProvisionalNavigation(WKNavigation)
        case didCommit(WKNavigation)
        case didFinish(WKNavigation)
        case didFailProvisionalNavigation(WKNavigation, Error)
        case didFail(WKNavigation, Error)
    }
    
    @ObservedObject var webViewStateModel: XTRWebViewStateModel
    
    private var actionDelegate: ((_ navigationAction: XTRWebView.NavigationAction) -> Void)?
    let uRLRequest: URLRequest
    
    var body: some View {
        XTRWebViewWrapper(webViewStateModel: webViewStateModel, action: actionDelegate, request: uRLRequest)
    }
    /*
     if passed onNavigationAction it is mandatory to complete URLAuthenticationChallenge and decidePolicyFor callbacks
     */
    init(uRLRequest: URLRequest, webViewStateModel: XTRWebViewStateModel, onNavigationAction: ((_ navigationAction: XTRWebView.NavigationAction) -> Void)?) {
        self.uRLRequest = uRLRequest
        self.webViewStateModel = webViewStateModel
        self.actionDelegate = onNavigationAction
    }
    
    init(url: URL, webViewStateModel: XTRWebViewStateModel, onNavigationAction: ((_ navigationAction: XTRWebView.NavigationAction) -> Void)? = nil) {
        self.init(uRLRequest: URLRequest(url: url), webViewStateModel: webViewStateModel, onNavigationAction: onNavigationAction)
    }
    
}
