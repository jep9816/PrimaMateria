//
//  XTRWikiPediaView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/18/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct XTRWikipediaViewConfig {
    static let preferredContentSize = CGSize(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.height - 50)
}

struct XTRWikiPediaView: View {
    @EnvironmentObject var environment: WikipediaEnvironment
    @ObservedObject var webViewStateModel: XTRWebViewStateModel = XTRWebViewStateModel()
    var dismissAction: (() -> Void)
    
    var body: some View {
        NavigationView {
            ZStack {
                XTRLoadingView(isShowing: .constant(webViewStateModel.loading)) {
                    //loading logic taken from https://stackoverflow.com/a/56496896/9838937
                    //Add onNavigationAction if callback needed
                    XTRWebView(url: URL(string: environment.wikipediaPath)!, webViewStateModel: self.webViewStateModel)
                        .frame(width: XTRWikipediaViewConfig.preferredContentSize.width - 2, height: XTRWikipediaViewConfig.preferredContentSize.height - 38).offset(x: 0, y: 0)
                }
                .navigationBarTitle(Text(webViewStateModel.pageTitle), displayMode: .inline)
                .navigationBarItems(
                    leading:
                        HStack {
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
                            .font(.system(size: 26, weight: .bold))
                        },
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
                .frame(width: XTRWikipediaViewConfig.preferredContentSize.width - 2, height: XTRWikipediaViewConfig.preferredContentSize.height - 2).offset(x: 0, y: 0)
            }
            .background(Color(XTRColorFactory.helpBackgroundColor))
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Spacer()
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(action: dismissAction) {
                        Text(NSLocalizedString("close", comment: ""))
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Spacer()
                }
            }
        }
    }
    
}

struct XTRWikiPediaView_Previews: PreviewProvider {
    
    static var previews: some View {
        XTRWikiPediaView(dismissAction: { })
    }
    
}
