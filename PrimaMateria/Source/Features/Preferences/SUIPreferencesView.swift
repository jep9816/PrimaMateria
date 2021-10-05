//
//  SUIPreferencesView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/22/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct SUIPreferencesViewConfig {
    static let preferredContentSize = CGSize(width: 270, height: 270)
    static let creditsDocument = "Credits.pdf"
}

struct SUIPreferencesView: View {
    
    @ObservedObject var webViewStateModel: SUIWebViewStateModel = SUIWebViewStateModel()
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(XTRColorFactory.backgroundColor)
                    .ignoresSafeArea()
                
                HStack(alignment: .top, spacing: 5) {
                    VStack(spacing: 0) {
                        SUIPreferencesSettingsView()
                        
                        Spacer()
                            // swiftlint:disable colon
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 5, alignment: .center)
                        
                        SUIPreferencesSeriesColorsView()
                        
                        Spacer()
                        
                        VStack(spacing: 0) {
                            SUIBaseButton(action: {
                                self.showingAlert = true
                            }, labelText: NSLocalizedString("resetPreferences", comment: "Reset Preferences"), width: 230, height: 32, backgroundColor: Color(XTRColorFactory.labelColor))
                            .alert(isPresented: $showingAlert) {
                                Alert(
                                    title: Text(NSLocalizedString("resetPreferences", comment: "Reset Preferences")),
                                    message: Text(NSLocalizedString("resetPreferencesDefault", comment: "Reset Preferences Default")),
                                    primaryButton: .default(
                                        Text(NSLocalizedString("yes", comment: "Yes")), action: {
                                            self.resetPreferences()
                                        }
                                    ), secondaryButton: .default(Text(NSLocalizedString("no", comment: "NO")), action: {
                                    })
                                )
                            }
                        }
                    }
                    
                    SUIPreferencesInfoView()
                }
                .padding(5)
            }
            .navigationBarTitle(NSLocalizedString("preferences", comment: "Preferences"), displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func resetPreferences() {
        XTRPropertiesStore.resetPreferences()
        NotificationCenter.default.post(name: .notificationAppearanceChanged, object: XTRAppearanceType.classic.name)

        LocaleManager.apply(locale: Locale(identifier: LanguageCodes.English.code()))
    }
    
}

struct SUIPreferencesView_Previews: PreviewProvider {
    
    static var previews: some View {
        SUIPreferencesView().previewLayout(.fixed(width: 1024, height: 768)) // 9.7
        //SUIPreferencesView().previewLayout(.fixed(width: 2732 / 2, height: 2048 / 2)) // iPad pro
    }
    
}
