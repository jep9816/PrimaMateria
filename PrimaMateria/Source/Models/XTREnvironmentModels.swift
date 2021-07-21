//
//  XTREnvironmentModels.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/30/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI

class ElementBallonEnvironment: ObservableObject {
    
    @Published var element: XTRElementModel!

    init(element: XTRElementModel) {
        self.element = element
    }
    
}

class WikipediaEnvironment: ObservableObject {
    
    @Published var wikipediaPath = ""
    
    init(wikipediaPath: String) {
        self.wikipediaPath = wikipediaPath
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

class MolecularCalculatorModel: ObservableObject {
    
    @Published var element: XTRElementModel!
    
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

class ColorPickerEnvironment: ObservableObject {
    @Published var seriesIdentifier: String?
    @Published var color: UIColor?
    
    init(seriesIdentifier: String, color: UIColor) {
        self.seriesIdentifier = seriesIdentifier
        self.color = color
    }

}
