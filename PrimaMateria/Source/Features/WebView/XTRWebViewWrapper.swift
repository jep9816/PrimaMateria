//
//  WebViewWrapper.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/18/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import SwiftUI
import WebKit

final class XTRWebViewWrapper: UIViewRepresentable {
    
    @ObservedObject var webViewStateModel: XTRWebViewStateModel
    let action: ((_ navigationAction: XTRWebView.NavigationAction) -> Void)?
    
    let request: URLRequest
    
    init(webViewStateModel: XTRWebViewStateModel,
         action: ((_ navigationAction: XTRWebView.NavigationAction) -> Void)?,
         request: URLRequest) {
        self.action = action
        self.request = request
        self.webViewStateModel = webViewStateModel
    }
        
    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        
        view.navigationDelegate = context.coordinator
        view.load(request)
        
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if uiView.canGoBack, webViewStateModel.goBack {
            uiView.goBack()
            webViewStateModel.goBack = false
        }
        if uiView.canGoForward, webViewStateModel.goForward {
            uiView.goForward()
            webViewStateModel.goForward = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(action: action, webViewStateModel: webViewStateModel)
    }
    
    final class Coordinator: NSObject {
        @ObservedObject var webViewStateModel: XTRWebViewStateModel
        let action: ((_ navigationAction: XTRWebView.NavigationAction) -> Void)?
        
        init(action: ((_ navigationAction: XTRWebView.NavigationAction) -> Void)?,
             webViewStateModel: XTRWebViewStateModel) {
            self.action = action
            self.webViewStateModel = webViewStateModel
        }
        
    }
    
}
