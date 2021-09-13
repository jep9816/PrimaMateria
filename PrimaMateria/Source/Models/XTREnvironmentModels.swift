//
//  XTREnvironmentModels.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/30/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import SwiftUI

class ElementBallonEnvironment: ObservableObject {
    
    @Published var element: XTRElementModel!

    init(element: XTRElementModel) {
        self.element = element
    }
    
}

class WikipediaEnvironment: ObservableObject {
    
    @Published var articlePath = ""
    
    init(articlePath: String) {
        self.articlePath = articlePath
    }
}

class HelpBallonEnvironment: ObservableObject {
    
    @Published var pageTitle = ""
    @Published var elementTipPath = ""
    
}

class InfoEnvironment: ObservableObject {
    
    @Published var pageTitle = ""
    
}

class MolecularCalculatorEnvironment: ObservableObject {
    
    @Published var element: XTRElementModel!
    
}

class ColorPickerEnvironment: ObservableObject {
    
    @Published var seriesIdentifier: String?
    @Published var seriesColor: UIColor?
    
    init(seriesIdentifier: String, seriesColor: UIColor) {
        self.seriesIdentifier = seriesIdentifier
        self.seriesColor = seriesColor
    }

}

class PreferencesEnvironment: ObservableObject {
    
    @Published var elementHelpBubbles = false
    @Published var showSplashScreen = false
    @Published var showViewTransitions = false
    @Published var selectedStyle = 0
    
}

class MolecularCalculatorModel: ObservableObject {
    
    @Published var element: XTRElementModel!
    
}

class ElementButtonEnvironment: ObservableObject {
    
    @Published var symbol: String!
    
}
class MolecularCalculatorProperty: ObservableObject {
    
    @Published var propertyValue: String = ""
    
}

class XTRWebViewStateModel: ObservableObject {
    
    @Published var pageTitle: String = "Web View"
    @Published var loading: Bool = false
    @Published var canGoBack: Bool = false
    @Published var goBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var goForward: Bool = false
    
}
