//
//  XTRGraphChoiceView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/22/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct XTRGraphChoiceViewConfig {
    static let buttonSize = CGSize(width: 240.0, height: 60.0)
    static let preferredContentSize = CGSize(width: (buttonSize.width + 3) * 3, height: (buttonSize.height + 3) * 10)
}

struct XTRGraphChoiceView: View {
    
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    private var graphChoiceTitles = XTRDataSource.sharedInstance.graphPropertyList
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: gridItemLayout, spacing: 1) {
                    ForEach(0...graphChoiceTitles.count - 1, id: \.self) {
                        let tag = $0
                        let model: XTRGraphDefinitionModel = graphChoiceTitles[tag]
                        let title = NSLocalizedString(model.title, comment: "")
                        
                        // swiftlint:disable multiple_closures_with_trailing_closure
                        Button(action: {
                            postGraphSelectedNotification(tag)
                        }) {
                            Text(title)
                                .lineLimit(nil)
                                .frame(width: XTRGraphChoiceViewConfig.buttonSize.width, height: XTRGraphChoiceViewConfig.buttonSize.height)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .background(Color(XTRColorFactory.labelColor))
                                .shadow(color: .black, radius: 1, x: 1, y: 1)
                        }
                        .border(Color.black, width: 1)
                    }
                }
            }
            .frame(width: XTRGraphChoiceViewConfig.preferredContentSize.width + 8, height: XTRGraphChoiceViewConfig.preferredContentSize.height).offset(x: 0, y: 2)
            .cornerRadius(VIEW_CORNER_RADIUS)
        }
        .frame(width: XTRGraphChoiceViewConfig.preferredContentSize.width + 30, height: XTRGraphChoiceViewConfig.preferredContentSize.height - 4).offset(x: 0, y: 8)
        .background(Color(XTRColorFactory.backgroundColor))
    }
    
    func postGraphSelectedNotification(_ tag: Int) {
        NotificationCenter.default.post(name: .graphSelectedNotification, object: tag)
        
    }
    
}

struct XTRGraphChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        XTRGraphChoiceView().previewLayout(.fixed(width: 1024, height: 768))
    }
}
