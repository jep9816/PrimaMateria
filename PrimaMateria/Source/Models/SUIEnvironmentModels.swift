//
//  SUIEnvironmentModels.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/30/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import SwiftUI

class SUIElementBallonEnvironment: ObservableObject {
    
    @Published var element: XTRElementModel!

    init(element: XTRElementModel) {
        self.element = element
    }
    
}

class SUIWikipediaEnvironment: ObservableObject {
    
    @Published var articlePath = ""
    
    init(articlePath: String) {
        self.articlePath = articlePath
    }
}

class SUIHelpBallonEnvironment: ObservableObject {
    
    @Published var pageTitle = ""
    @Published var elementTipPath = ""
    
}

class SUIInfoEnvironment: ObservableObject {
    
    @Published var pageTitle = ""
    
}

class SUIMolecularCalculatorEnvironment: ObservableObject {
    
    @Published var element: XTRElementModel!
    
}

class SUIColorPickerEnvironment: ObservableObject {
    
    @Published var seriesIdentifier: String?
    @Published var seriesColor: UIColor?
    
    init(seriesIdentifier: String, seriesColor: UIColor) {
        self.seriesIdentifier = seriesIdentifier
        self.seriesColor = seriesColor
    }

}

class SUIPreferencesEnvironment: ObservableObject {
    
    @Published var elementHelpBubbles = false
    @Published var showSplashScreen = false
    @Published var showViewTransitions = false
    @Published var selectedStyle = 0
    
}

class SUIMolecularCalculatorModel: ObservableObject {
    
    @Published var element: XTRElementModel!
    
}

class SUIElementButtonEnvironment: ObservableObject {
    
    @Published var symbol: String!
    
}
class SUIMolecularCalculatorProperty: ObservableObject {
    
    @Published var propertyValue: String = ""
    
}

class SUIWebViewStateModel: ObservableObject {
    
    @Published var pageTitle: String = "Web View"
    @Published var loading: Bool = false
    @Published var canGoBack: Bool = false
    @Published var goBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var goForward: Bool = false
    
}
