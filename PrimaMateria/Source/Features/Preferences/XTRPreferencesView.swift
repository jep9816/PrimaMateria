//
//  XTRPreferencesView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/22/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct XTRPreferencesViewConfig {
    static let preferredContentSize = CGSize(width: 270, height: 270)
    static let creditsDocument = "Credits.pdf"
}

struct XTRPreferencesView: View {
    
    @ObservedObject var webViewStateModel: XTRWebViewStateModel = XTRWebViewStateModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(XTRColorFactory.backgroundColor)
                    .ignoresSafeArea()
                
                HStack(alignment: .top, spacing: 5) {
                    VStack(spacing: 0) {
                        XTRPreferencesSettingsView()
                        
                        Spacer(minLength: 5)
                        
                        XTRPreferencesSeriesColorsView()
                        
                        Spacer(minLength: 5)
                        
                        VStack(spacing: 0) {
                            XTRBaseButton(action: {}, labelText: NSLocalizedString("resetPreferences", comment: "Reset Preferences"), width: 230, height: 32, backgroundColor: Color(XTRColorFactory.labelColor))
                        }
                    }
                    
                    XTRPreferencesInfoView()
                }
                .padding(5)
            }
            .navigationBarTitle(NSLocalizedString("preferences", comment: "Preferences"), displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct XTRPreferencesView_Previews: PreviewProvider {
    
    static var previews: some View {
        XTRPreferencesView().previewLayout(.fixed(width: 1024, height: 768))
    }
    
}
