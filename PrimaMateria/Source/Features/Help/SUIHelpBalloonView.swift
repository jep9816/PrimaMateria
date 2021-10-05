//
//  SUIHelpBalloon.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/17/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct SUIHelpBalloonViewConfig {
    static let preferredContentSize = CGSize(width: 500, height: 400)
}

struct SUIHelpBalloonView: View {
    @EnvironmentObject var environment: SUIHelpBallonEnvironment
    @ObservedObject var webViewStateModel: SUIWebViewStateModel = SUIWebViewStateModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                SUILoadingView(isShowing: .constant(webViewStateModel.loading)) {
                    //loading logic taken from https://stackoverflow.com/a/56496896/9838937
                    //Add onNavigationAction if callback needed
                    SUIWebView(url: URL(fileURLWithPath: environment.elementTipPath), webViewStateModel: self.webViewStateModel)
                        .frame(width: SUIHelpBalloonViewConfig.preferredContentSize.width - 2, height: SUIHelpBalloonViewConfig.preferredContentSize.height - 38).offset(x: 0, y: 0)
                        .background(Color(XTRColorFactory.helpBackgroundColor))
                }
                .background(Color(XTRColorFactory.helpBackgroundColor))
                .navigationBarTitle(Text(webViewStateModel.pageTitle), displayMode: .inline)
                .navigationBarItems(
                    leading:
                        // swiftlint:disable multiple_closures_with_trailing_closure
                        Button(action: {
                            self.webViewStateModel.goBack.toggle()
                        }) {
                            Label("Left Arrow", systemImage: "arrowtriangle.left.fill")
                                .labelStyle(IconOnlyLabelStyle())
                                .frame(width: SUIWebViewConfig.barButtonSize.width, height: SUIWebViewConfig.barButtonSize.height, alignment: .leading)
                        }
                        .opacity(!webViewStateModel.canGoBack ? 0: 1)
                        .disabled(!webViewStateModel.canGoBack)
                        .aspectRatio(contentMode: .fill)
                        .font(XTRFontFactory.boldSystem26),
                    trailing:
                        // swiftlint:disable multiple_closures_with_trailing_closure
                        Button(action: {
                            self.webViewStateModel.goForward.toggle()
                        }) {
                            Label("Right Arrow", systemImage: "arrowtriangle.right.fill")
                                .labelStyle(IconOnlyLabelStyle())
                                .frame(width: SUIWebViewConfig.barButtonSize.width, height: SUIWebViewConfig.barButtonSize.height, alignment: .trailing)
                        }
                        .opacity(!webViewStateModel.canGoForward ? 0: 1)
                        .disabled(!webViewStateModel.canGoForward)
                        .aspectRatio(contentMode: .fill)
                        .font(XTRFontFactory.boldSystem26)
                )
                .frame(width: SUIHelpBalloonViewConfig.preferredContentSize.width - 2, height: SUIHelpBalloonViewConfig.preferredContentSize.height - 2).offset(x: 0, y: 0)
            }
            .background(Color(XTRColorFactory.helpBackgroundColor))
       }
    }
    
}

struct SUIHelpBalloon_Previews: PreviewProvider {
    
    static var previews: some View {
        SUIHelpBalloonView().environmentObject(SUIHelpBallonEnvironment())
            .previewLayout(.fixed(width: SUIHelpBalloonViewConfig.preferredContentSize.width, height: SUIHelpBalloonViewConfig.preferredContentSize.height))
    }
    
}
