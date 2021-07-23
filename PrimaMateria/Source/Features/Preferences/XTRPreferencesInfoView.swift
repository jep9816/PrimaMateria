//
//  XTRPreferencesInfoView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/22/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI
import Combine

enum LanguageCodes: String {
    
    case English = "en"
    case Spanish = "es"
    case Russian = "ru"
    case French = "fr"
    
    func code() -> String {
        return self.rawValue
    }
    
}

struct XTRPreferencesInfoView: View {
    
    @ObservedObject var webViewStateModel: XTRWebViewStateModel = XTRWebViewStateModel()
    @State private var showingAlert = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .bottom, spacing: 5) {
                Image("icon")
                
                Text("Xtrensa")
                    .font(Font.custom("Papyrus", size: 36.0))
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                
                Spacer()
                
                Text(Bundle.main.appNameString!)
                    .font(Font.custom("Papyrus", size: 48.0))
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .frame(width: 320, height: 54, alignment: .center)

                Spacer()
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 5) {
                        Text(NSLocalizedString("version", comment: "Version") + ":")
                            .font(Font.custom("Papyrus", size: 18.0))
                            .fontWeight(.regular)
                            .foregroundColor(Color(XTRColorFactory.backgroundColor))
                            .frame(width: 140, height: 24, alignment: .trailing)
                        
                        Text(" " + Bundle.main.appVersionString!)
                            .font(Font.custom("Papyrus", size: 18.0))
                            .fontWeight(.regular)
                            .foregroundColor(Color(XTRColorFactory.backgroundColor))
                            .frame(width: 60, height: 24, alignment: .leading)
                    }
                    
                    HStack(spacing: 5) {
                        Text(NSLocalizedString("copyright", comment: "Copyright") + ":")
                            .font(Font.custom("Papyrus", size: 18.0))
                            .fontWeight(.regular)
                            .foregroundColor(Color(XTRColorFactory.backgroundColor))
                            .frame(width: 140, height: 24, alignment: .trailing)

                        Text(Bundle.main.copywriteString!)
                            .font(Font.custom("Papyrus", size: 18.0))
                            .fontWeight(.regular)
                            .foregroundColor(Color(XTRColorFactory.backgroundColor))
                            .frame(width: 60, height: 24, alignment: .leading)
                            .padding(5)
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
                
                //swiftlint:disable no_space_in_method_call
                Menu {
                    Text(NSLocalizedString("chooseLanguage", comment: ""))
                    
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
                    // swiftlint:disable multiple_closures_with_trailing_closure
               } label: {
                    XTRPreferencesGlobeView()
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
                XTRLoadingView(isShowing: .constant(webViewStateModel.loading)) {
                    XTRWebView(url: URL(fileURLWithPath: creditsPath(documentName: XTRPreferencesViewConfig.creditsDocument)), webViewStateModel: self.webViewStateModel)
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

struct XTRPreferencesInfoView_Previews: PreviewProvider {
    
    static var previews: some View {
        XTRPreferencesInfoView().previewLayout(.fixed(width: 1024, height: 768))
    }
    
}
