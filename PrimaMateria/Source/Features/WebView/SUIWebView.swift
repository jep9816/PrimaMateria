//
//  SUIWebView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/18/21.
//  Copyright ©2023 Jerry Porter. All rights reserved.
//

import SwiftUI
import WebKit

struct SUIWebViewConfig {
    static let barButtonSize = CGSize(width: 44, height: 44)
}

struct SUIWebView: View {
    
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
    
    @ObservedObject var webViewStateModel: SUIWebViewStateModel
    
    private var actionDelegate: ((_ navigationAction: SUIWebView.NavigationAction) -> Void)?
    let uRLRequest: URLRequest
    
    var body: some View {
        SUIWebViewWrapper(webViewStateModel: webViewStateModel, action: actionDelegate, request: uRLRequest)
    }
    /*
     if passed onNavigationAction it is mandatory to complete URLAuthenticationChallenge and decidePolicyFor callbacks
     */
    init(uRLRequest: URLRequest, webViewStateModel: SUIWebViewStateModel, onNavigationAction: ((_ navigationAction: SUIWebView.NavigationAction) -> Void)?) {
        self.uRLRequest = uRLRequest
        self.webViewStateModel = webViewStateModel
        self.actionDelegate = onNavigationAction
    }
    
    init(url: URL, webViewStateModel: SUIWebViewStateModel, onNavigationAction: ((_ navigationAction: SUIWebView.NavigationAction) -> Void)? = nil) {
        self.init(uRLRequest: URLRequest(url: url), webViewStateModel: webViewStateModel, onNavigationAction: onNavigationAction)
    }
    
}
