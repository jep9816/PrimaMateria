//
//  SUIElementInspectorView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 10/4/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct SUIElementInspectorViewConfig {
    static let preferredContentSize = CGSize(width: 1024.0, height: 768.0)
}

struct SUIElementInspectorView: View {
    
    @EnvironmentObject var environment: SUIElementBallonEnvironment
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                HStack(alignment: .top, spacing: 0) {
                    Text(environment.element.symbol!)
                        .font(XTRFontFactory.boldSystem57)
                        .frame(width: 118, height: 66, alignment: .center)
                        .border(Color.black, width: 1)
                        .background(Color(environment.element.seriesColor))
                        .foregroundColor(Color(environment.element.standardConditionColor))
                    
                    HStack(spacing: 5) {
                        SUIHelpButtonView(helpKey: "atomicNumber")
                        Text(NSLocalizedString("atomicNumber", comment: "Atomic Number"))
                    }
                    .frame(width: 123, height: 66, alignment: .leading)
                    .border(Color.black, width: 1)

                    Text("\(environment.element.atomicNumber)")
                        .font(XTRFontFactory.system45)
                        .frame(width: 82, height: 66, alignment: .center)
                        .border(Color.black, width: 1)
                    
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            SUIHelpButtonView(helpKey: "group")
                            Text(" " + NSLocalizedString("group", comment: "Group"))
                        }
                        .frame(width: 115, height: 33, alignment: .leading)
                       .border(Color.black, width: 1)
                        
                       HStack(spacing: 0) {
                            SUIHelpButtonView(helpKey: "period")
                            
                            Text(" " + NSLocalizedString("period", comment: "Period"))
                        }
                       .frame(width: 98, height: 33, alignment: .leading)
                      .border(Color.black, width: 1)
                    }
                    .frame(width: 98, height: 66, alignment: .leading)
                    .border(Color.black, width: 1)
                    
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Text("8 ")
                        }
                        .frame(width: 98, height: 33, alignment: .trailing)
                       .border(Color.black, width: 1)
                        
                        HStack(spacing: 0) {
                            Text("4 ")
                        }
                        .frame(width: 98, height: 33, alignment: .trailing)
                        .border(Color.black, width: 1)
                    }
                    .frame(width: 98, height: 66, alignment: .trailing)
                    .border(Color.black, width: 1)
                    
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            SUIHelpButtonView(helpKey: "series")
                            Text(NSLocalizedString("series", comment: "Series"))
                        }
                        .border(Color.black, width: 1)

                        HStack(spacing: 0) {
                            SUIHelpButtonView(helpKey: "casResNo")
                            Text(NSLocalizedString("casResNo", comment: "CAS Registry Number"))
                        }
                        .border(Color.black, width: 1)
                    }
                    .frame(width: 183, height: 66, alignment: .leading)
                    .border(Color.black, width: 1)
                    
                    /*VStack(spacing: 0) {
                        Text("Transition Metal")
                            .border(Color.black, width: 1)
                       Text("7439-89-6")
                            .border(Color.black, width: 1)
                    }
                    .frame(width: 275, height: 66, alignment: .leading)
                    .border(Color.black, width: 1)*/
                }
                Text("Tabbed Area")
                Spacer()
                
            }
        }
    }
}

struct SUIElementInspectorView_Previews: PreviewProvider {
    static var previews: some View {
        SUIElementInspectorView().environmentObject(SUIElementBallonEnvironment(element: XTRElementModel.testElement()))
            .previewLayout(.fixed(width: SUIElementInspectorViewConfig.preferredContentSize.width, height: SUIElementInspectorViewConfig.preferredContentSize.height))
    }
}
