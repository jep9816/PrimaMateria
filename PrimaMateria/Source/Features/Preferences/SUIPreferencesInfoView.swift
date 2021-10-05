//
//  SUIPreferencesInfoView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/22/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI
import Combine

struct SUIPreferencesInfoView: View {
    
    @ObservedObject var webViewStateModel: SUIWebViewStateModel = SUIWebViewStateModel()
    @State private var showingAlert = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .bottom, spacing: 5) {
                Image("icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 54, height: 54, alignment: .center)

                Text("Xtrensa")
                    .font(XTRFontFactory.papyrusSystem36)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .frame(width: 130, height: 44, alignment: .center)

                Spacer()
                
                Text(Bundle.main.appNameString!)
                    .font(XTRFontFactory.papyrusSystem48)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .frame(width: 320, height: 40, alignment: .center)

                Spacer()
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 5) {
                        Text(NSLocalizedString("version", comment: "Version") + ":")
                            .font(XTRFontFactory.papyrusSystem18)
                            .fontWeight(.regular)
                            .foregroundColor(Color(XTRColorFactory.backgroundColor))
                            .frame(width: 140, height: 24, alignment: .trailing)
                        
                        Text(Bundle.main.appVersionString!)
                            .font(XTRFontFactory.papyrusSystem18)
                            .fontWeight(.regular)
                            .foregroundColor(Color(XTRColorFactory.backgroundColor))
                            .frame(width: 60, height: 24, alignment: .leading)
                    }
                    
                    HStack(spacing: 5) {
                        Text(NSLocalizedString("copyright", comment: "Copyright") + ":")
                            .font(XTRFontFactory.papyrusSystem18)
                            .fontWeight(.regular)
                            .foregroundColor(Color(XTRColorFactory.backgroundColor))
                            .frame(width: 140, height: 30, alignment: .trailing)

                        Text(Bundle.main.copywriteString!)
                            .font(XTRFontFactory.papyrusSystem18)
                            .fontWeight(.regular)
                            .foregroundColor(Color(XTRColorFactory.backgroundColor))
                            .frame(width: 60, height: 30, alignment: .leading)
                    }
                }
            }
            .border(Color.black, width: 1)
            .background(Color(XTRColorFactory.tableViewCellBorderColor))
            
            HStack(spacing: 0) {
                Spacer()
                Text(NSLocalizedString("credits", comment: "Credits"))
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Menu {
                    Label(NSLocalizedString("chooseLanguage", comment: "Choose Language"), systemImage: "globe")
                    
                    Button("🇺🇸 " + NSLocalizedString("english", comment: "English"), action: {
                        XTRPropertiesStore.currentLanguageCode = LanguageCodes.English.code()
                        showingAlert.toggle()
                    })
                    .disabled(XTRPropertiesStore.currentLanguageCode == "en")
                    
                    Button("🇪🇸 " + NSLocalizedString("spanish", comment: "Spanish"), action: {
                        XTRPropertiesStore.currentLanguageCode = LanguageCodes.Spanish.code()
                        showingAlert.toggle()
                    })
                    .disabled(XTRPropertiesStore.currentLanguageCode == "es")
                    
                    Button("🇷🇺 " + NSLocalizedString("russian", comment: "Russian"), action: {
                        XTRPropertiesStore.currentLanguageCode = LanguageCodes.Russian.code()
                        showingAlert.toggle()
                    })
                    .disabled(XTRPropertiesStore.currentLanguageCode == "ru")
                    
                    Button("🇫🇷 " + NSLocalizedString("french", comment: "French"), action: {
                        XTRPropertiesStore.currentLanguageCode = LanguageCodes.French.code()
                        showingAlert.toggle()
                    })
                    .disabled(XTRPropertiesStore.currentLanguageCode == "fr")
                } label: {
                    SUIPreferencesGlobeView()
                        .frame(width: 44, height: 44, alignment: .center)
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text(NSLocalizedString("languageChanged", comment: "Language Changed")),
                    message: Text(String.localizedStringWithFormat(NSLocalizedString("%@ restartApp", comment: ""), Bundle.main.appNameString!)),
                    dismissButton: .default(
                        Text(NSLocalizedString("ok", comment: "OK")), action: {
                            LocaleManager.apply(locale: Locale(identifier: XTRPropertiesStore.currentLanguageCode))
                        }
                    )
                )
            }
            .padding(5)
            .border(Color.black, width: 1)
            .background(Color.gray)
            
            VStack(spacing: 0) {
                SUILoadingView(isShowing: .constant(webViewStateModel.loading)) {
                    SUIWebView(url: URL(fileURLWithPath: creditsPath(documentName: SUIPreferencesViewConfig.creditsDocument)), webViewStateModel: self.webViewStateModel)
                }
            }
            .background(Color(XTRColorFactory.tableViewCellBorderColor))
            .border(Color(XTRColorFactory.backgroundColor), width: 2)
        }
    }
    
    func creditsPath(documentName: String) -> String {
        guard let path = Bundle.main.path(forResource: documentName, ofType: nil) else { return "" }
        return path
    }
        
}

struct SUIPreferencesInfoView_Previews: PreviewProvider {
    
    static var previews: some View {
        SUIPreferencesInfoView().previewLayout(.fixed(width: 1024, height: 768))
    }
    
}
