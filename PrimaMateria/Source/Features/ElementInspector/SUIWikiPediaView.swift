//
//  SUIWikiPediaView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/18/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct SUIWikipediaViewConfig {
    static let preferredContentSize = CGSize(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.height - 50)
}

struct SUIWikiPediaView: View {
    @EnvironmentObject var environment: SUIWikipediaEnvironment
    @ObservedObject var webViewStateModel: SUIWebViewStateModel = SUIWebViewStateModel()
    var dismissAction: (() -> Void)
    
    var body: some View {
        NavigationView {
            ZStack {
                SUILoadingView(isShowing: .constant(webViewStateModel.loading)) {
                    //loading logic taken from https://stackoverflow.com/a/56496896/9838937
                    //Add onNavigationAction if callback needed
                    SUIWebView(url: URL(string: environment.articlePath)!, webViewStateModel: self.webViewStateModel)
                        .frame(width: SUIWikipediaViewConfig.preferredContentSize.width - 2, height: SUIWikipediaViewConfig.preferredContentSize.height - 38).offset(x: 0, y: 0)
                }
                .navigationBarTitle(Text(webViewStateModel.pageTitle), displayMode: .inline)
                .navigationBarItems(
                    leading:
                        Button(action: dismissAction) {
                            Text(NSLocalizedString("close", comment: ""))
                        },
                    trailing:
                        HStack(spacing: 0) {
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
                            .font(XTRFontFactory.boldSystem26)
                            
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
                        }
                )
                .frame(width: SUIWikipediaViewConfig.preferredContentSize.width - 2, height: SUIWikipediaViewConfig.preferredContentSize.height - 2).offset(x: 0, y: 0)
            }
            .background(Color(XTRColorFactory.helpBackgroundColor))
            //.toolbar {
            //    ToolbarItem(placement: .bottomBar) {
            //        Spacer()
            //    }
            //    ToolbarItem(placement: .bottomBar) {
            //        Button(action: dismissAction) {
            //            Text(NSLocalizedString("close", comment: ""))
            //        }
            //    }
            //    ToolbarItem(placement: .bottomBar) {
            //        Spacer()
            //    }
            //}
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct XTRWikiPediaView_Previews: PreviewProvider {
    
    static var previews: some View {
        SUIWikiPediaView(dismissAction: { })
            .environmentObject(SUIWikipediaEnvironment(articlePath: "http://www.wikipedia.org"))
            .previewLayout(.fixed(width: 1024, height: 768))
    }
    
}
