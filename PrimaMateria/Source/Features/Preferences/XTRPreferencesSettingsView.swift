//
//  XTRPreferencesSettingsView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/22/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct XTRPreferencesSettingsView: View {
    
    @State private var elementHelpBubbles = false
    @State private var showSplashScreen = false
    @State private var showViewTransitions = false
    @State private var selectedStyle = 0
    
    var body: some View {
        HStack(spacing: 5) {
            VStack(alignment: .leading, spacing: 0) {
                Text(NSLocalizedString("settings", comment: "Settings"))
                    .font(.system(size: 18, weight: .regular))
                    //swiftlint:disable colon
                    .frame(width: 230, height: 21, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Toggle(NSLocalizedString("elementHelpBubbles", comment: "Element Help Bubbles") + ": ", isOn: $elementHelpBubbles)
                    .font(.system(size: 14, weight: .regular))
                Spacer(minLength: 5)
                Toggle(NSLocalizedString("showSplashScreen", comment: "Show Splash Screen") + ": ", isOn: $showSplashScreen)
                    .font(.system(size: 14, weight: .regular))
                Spacer(minLength: 5)

                Toggle(NSLocalizedString("showViewTransitions", comment: "Show View Transitions") + ": ", isOn: $showViewTransitions)
                    .font(.system(size: 14, weight: .regular))
                Spacer(minLength: 5)

                HStack(spacing: 0) {
                    Text(NSLocalizedString("style", comment: "style") + ": ")
                        .font(.system(size: 14, weight: .regular))
                    Picker(NSLocalizedString("style", comment: "style"), selection: $selectedStyle, content: {
                        Text(NSLocalizedString("classic", comment: "Classic")).tag(0)
                        Text(NSLocalizedString("standard", comment: "Standard")).tag(1)
                    })
                    .pickerStyle(SegmentedPickerStyle())
                    .font(.system(size: 14, weight: .regular))
                    //swiftlint:disable colon
                    .frame(width: 160, height: 29, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                Spacer(minLength: 5)
            }
            .frame(width: 230, height: 160, alignment: .center)
            .padding(5)
            .background(Color(XTRColorFactory.tableViewCellBorderColor))
        }
    }
    
}

struct XTRPreferencesSettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        XTRPreferencesSettingsView().previewLayout(.fixed(width: 1024, height: 768))
    }
    
}
