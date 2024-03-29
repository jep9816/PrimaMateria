//
//  SUIInfoView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/29/21.
//  Copyright ©2023 Jerry Porter. All rights reserved.
//

import SwiftUI

struct SUIInfoView: View {
    
    @EnvironmentObject var environment: SUIInfoEnvironment
    @ObservedObject var webViewStateModel: SUIWebViewStateModel = SUIWebViewStateModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                SUILoadingView(isShowing: .constant(webViewStateModel.loading)) {
                    //loading logic taken from https://stackoverflow.com/a/56496896/9838937
                    //Add onNavigationAction if callback needed
                    SUIWebView(url: URL(fileURLWithPath: helpPath(documentName: "index")), webViewStateModel: self.webViewStateModel)
                        .background(Color(XTRColorFactory.helpBackgroundColor))
                }
                .background(Color(XTRColorFactory.helpBackgroundColor))
                .navigationBarTitle(NSLocalizedString("info", comment: "info"), displayMode: .inline)
            }
            .background(Color(XTRColorFactory.helpBackgroundColor))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func helpPath(documentName: String) -> String {
        guard let path = Bundle.main.path(forResource: documentName, ofType: FileType.html, inDirectory: "PrimaMateriaHelp/\(XTRPropertiesStore.currentLanguageCode)") else { return "" }
        return path
    }
    
}

struct XTRInfoView_Previews: PreviewProvider {
    
    static var previews: some View {
        SUIInfoView().previewLayout(.fixed(width: 1024, height: 768))
    }
    
}
