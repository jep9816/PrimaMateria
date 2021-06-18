//
//  WebViewStateModel.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/18/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import SwiftUI

class XTRWebViewStateModel: ObservableObject {
    
    @Published var pageTitle: String = "Web View"
    @Published var loading: Bool = false
    @Published var canGoBack: Bool = false
    @Published var goBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var goForward: Bool = false
    
}
