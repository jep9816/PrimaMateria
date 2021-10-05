//
//  SUIPreferencesSettingsView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/22/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct SUIPreferencesSettingsView: View {
    
    @State private var elementBubblesState = false
    @State private var splashScreenState = false
    @State private var showTransitionsState = false
    @State private var selectedStyle = 0
    
    var body: some View {
        HStack(spacing: 5) {
            VStack(alignment: .leading, spacing: 0) {
                Text(NSLocalizedString("settings", comment: "Settings"))
                    .font(XTRFontFactory.regularSystem18)
                    // swiftlint:disable colon
                    .frame(width: 230, height: 21, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Toggle(NSLocalizedString("elementHelpBubbles", comment: "Element Help Bubbles") + ": ", isOn: $elementBubblesState).onChange(of: elementBubblesState, perform: { _ in
                    XTRPropertiesStore.elementBubblesState = elementBubblesState
                })
                .font(XTRFontFactory.regularSystem14)
                
                Spacer(minLength: 5)
                
                Toggle(NSLocalizedString("showSplashScreen", comment: "Show Splash Screen") + ": ", isOn: $splashScreenState).onChange(of: splashScreenState, perform: { _ in
                    XTRPropertiesStore.splashScreenState = splashScreenState
                })
                .font(XTRFontFactory.regularSystem14)
                
                Spacer(minLength: 5)
                
                Toggle(NSLocalizedString("showViewTransitions", comment: "Show View Transitions") + ": ", isOn: $showTransitionsState).onChange(of: showTransitionsState, perform: { _ in
                    XTRPropertiesStore.showTransitionsState = showTransitionsState
                })
                .font(XTRFontFactory.regularSystem14)
                
                Spacer(minLength: 5)
                
                HStack(spacing: 0) {
                    Text(NSLocalizedString("style", comment: "style") + ": ")
                        .font(XTRFontFactory.regularSystem14)
                    Picker(NSLocalizedString("style", comment: "style"), selection: $selectedStyle, content: {
                        Text(NSLocalizedString("classic", comment: "Classic")).tag(XTRAppearanceType.classic.offset())
                        Text(NSLocalizedString("standard", comment: "Standard")).tag(XTRAppearanceType.standard.offset())
                    }).onChange(of: selectedStyle, perform: { _ in
                        let appearance = (selectedStyle == XTRAppearanceType.classic.offset()) ? XTRAppearanceType.classic: XTRAppearanceType.standard
                        XTRPropertiesStore.appearanceName = appearance.name
                        
                        NotificationCenter.default.post(name: .notificationAppearanceChanged, object: appearance.name)
                    })
                    .pickerStyle(SegmentedPickerStyle())
                    .font(XTRFontFactory.regularSystem14)
                    // swiftlint:disable colon
                    .frame(width: 160, height: 29, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                
                Spacer(minLength: 5)
            }
            .frame(width: 230, height: 160, alignment: .center)
            .padding(5)
            .background(Color(XTRColorFactory.tableViewCellBorderColor))
        }.onAppear(perform: {
            elementBubblesState = XTRPropertiesStore.elementBubblesState
            splashScreenState = XTRPropertiesStore.splashScreenState
            showTransitionsState = XTRPropertiesStore.showTransitionsState
            selectedStyle = XTRAppearanceManager.manager.isClassicAppearance() ? 0: 1
        })
    }
    
}

struct SUIPreferencesSettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SUIPreferencesSettingsView().previewLayout(.fixed(width: 1024, height: 768))
    }
    
}
