//
//  XTRHelpBalloon.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/17/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct XTRHelpBalloonViewConfig {
    static let preferredContentSize = CGSize(width: 500, height: 400)
}

struct XTRHelpBalloonView: View {
    @EnvironmentObject var environment: HelpBallonEnvironment
    @ObservedObject var webViewStateModel: XTRWebViewStateModel = XTRWebViewStateModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                XTRLoadingView(isShowing: .constant(webViewStateModel.loading)) {
                    //loading logic taken from https://stackoverflow.com/a/56496896/9838937
                    //Add onNavigationAction if callback needed
                    XTRWebView(url: URL(fileURLWithPath: environment.elementTipPath), webViewStateModel: self.webViewStateModel)
                        .frame(width: XTRHelpBalloonViewConfig.preferredContentSize.width - 2, height: XTRHelpBalloonViewConfig.preferredContentSize.height - 38).offset(x: 0, y: 0)
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
                            Text("◀︎").lineLimit(1).font(.system(size: 26, weight: .bold))
                                .frame(width: XTRWebViewConfig.barButtonSize.width, height: XTRWebViewConfig.barButtonSize.height, alignment: .leading)
                        }
                        .opacity(!webViewStateModel.canGoBack ? 0: 1)
                        .disabled(!webViewStateModel.canGoBack)
                        .aspectRatio(contentMode: .fill)
                        .font(.system(size: 26, weight: .bold)),
                    trailing:
                        // swiftlint:disable multiple_closures_with_trailing_closure
                        Button(action: {
                            self.webViewStateModel.goForward.toggle()
                        }) {
                            Text("▶︎").lineLimit(1).font(.system(size: 26, weight: .bold))
                                .frame(width: XTRWebViewConfig.barButtonSize.width, height: XTRWebViewConfig.barButtonSize.height, alignment: .trailing)
                        }
                        .opacity(!webViewStateModel.canGoForward ? 0: 1)
                        .disabled(!webViewStateModel.canGoForward)
                        .aspectRatio(contentMode: .fill)
                        .font(.system(size: 26, weight: .bold))
                )
                .frame(width: XTRHelpBalloonViewConfig.preferredContentSize.width - 2, height: XTRHelpBalloonViewConfig.preferredContentSize.height - 2).offset(x: 0, y: 0)
            }
            .background(Color(XTRColorFactory.helpBackgroundColor))
       }
    }
    
}

struct XTRHelpBalloonSUI_Previews: PreviewProvider {
    
    static var previews: some View {
        XTRHelpBalloonView()
    }
    
}
