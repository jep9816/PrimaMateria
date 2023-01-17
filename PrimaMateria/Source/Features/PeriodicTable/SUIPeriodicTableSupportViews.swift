//
//  SUIPeriodicTableSupportViews.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 10/4/21.
//  Copyright ©2023 Jerry Porter. All rights reserved.
//

import SwiftUI

struct SUIElementButtonView: View {
    
    var element: XTRElementModel
    var width: CGFloat!
    var height: CGFloat!
    @State private var isPresented = false
    
    var body: some View {
        
        Text(element.symbol!)
            .frame(minWidth: width, maxWidth: .infinity, minHeight: height, maxHeight: .infinity, alignment: .center)
            .font(XTRFontFactory.boldSystem32)
            .background(Color(element.seriesColor))
            .foregroundColor(Color(element.standardConditionColor))
            .onTapGesture {
                isPresented.toggle()
            }
            .fullScreenCover(isPresented: $isPresented) {
                NavigationView {
                    SUIElementInspectorView().environmentObject(SUIElementBallonEnvironment(element: element))
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    isPresented = false
                                }, label: {
                                    Text(NSLocalizedString("close", comment: "Close"))
                                })
                            }
                        }
                        .navigationBarTitle(element.nameString(), displayMode: .inline)
                }
            }
            .cornerRadius(VIEW_CORNER_RADIUS)
    }
    
}

struct SUICalculatorButtonView: View {
    
    var buttonText: String!
    var function: () -> Void
    
    var body: some View {
        
        Button(action: function) {
            Text(buttonText)
                .font(XTRFontFactory.system32)
        }
    }
    
}

struct GroupLayoutView: View {
    
    var model: PeriodicTableLayoutItemModel!
    
    var body: some View {
        Text(model.symbol)
            .frame(width: SUIPeriodicTableViewConfig.buttonWidth, height: 20, alignment: .center)
            .foregroundColor(.white)
            .font(XTRFontFactory.system17)
        Text(model.elementNumber)
            .frame(width: SUIPeriodicTableViewConfig.buttonWidth, height: 32, alignment: .center)
            .foregroundColor(.white)
    }
    
}

struct GroupLeftLayoutView: View {
    
    var model: PeriodicTableLayoutItemModel!
    
    var body: some View {
        Text(model.symbol)
            .frame(width: SUIPeriodicTableViewConfig.buttonWidth, height: 20, alignment: .center)
            .foregroundColor(.white)
            .font(XTRFontFactory.system17)
        Text(model.elementNumber)
            .frame(width: SUIPeriodicTableViewConfig.buttonWidth, height: 32, alignment: .trailing)
            .foregroundColor(.white)
            .font(XTRFontFactory.system17)
    }
    
}

struct GroupRightLayoutView: View {
    
    var model: PeriodicTableLayoutItemModel!
    
    var body: some View {
        Text(model.symbol)
            .frame(width: SUIPeriodicTableViewConfig.buttonWidth, height: 20, alignment: .center)
            .foregroundColor(.white)
            .font(XTRFontFactory.system17)
        Text(model.elementNumber)
            .frame(width: SUIPeriodicTableViewConfig.buttonWidth, height: 32, alignment: .leading)
            .foregroundColor(.white)
            .font(XTRFontFactory.system17)
    }
    
}

struct PeriodLayoutView: View {
    
    var model: PeriodicTableLayoutItemModel!
    
    var body: some View {
        Text(model.symbol)
            .frame(width: 22, height: 22, alignment: .trailing)
            .foregroundColor(.white)
            .font(XTRFontFactory.system17)
    }
    
}

struct PlaceholderLayoutView: View {
    
    var model: PeriodicTableLayoutItemModel!
    
    var body: some View {
        Text("")
            .frame(width: SUIPeriodicTableViewConfig.buttonWidth, height: SUIPeriodicTableViewConfig.buttonHeight, alignment: .center)
    }
    
}

struct SeriesLabelLayoutView: View {
    
    var model: PeriodicTableLayoutItemModel!
    
    var body: some View {
        Text(NSLocalizedString(model.symbol, comment: "Symbol label"))
            .foregroundColor(.white)
            .frame(width: SUIPeriodicTableViewConfig.buttonWidth * 3, height: SUIPeriodicTableViewConfig.buttonHeight, alignment: .leading)
            .font(XTRFontFactory.system17)
    }
    
}

struct ButtonLayoutView: View {
    
    var model: PeriodicTableLayoutItemModel!
    
    var body: some View {
        SUIElementButtonView(element: XTRDataSource.sharedInstance.element(index: Int(model.elementNumber)! - 1), width: SUIPeriodicTableViewConfig.buttonWidth, height: SUIPeriodicTableViewConfig.buttonHeight)
    }
    
}

struct SUIElementButtonView_Previews: PreviewProvider {
    
    static var previews: some View {
        SUIElementButtonView(element: XTRElementModel.testElement())
    }
    
}

struct SUICalculatorButtonView_Previews: PreviewProvider {
    
    static var previews: some View {
        SUICalculatorButtonView(buttonText: "6", function: {})
    }
    
}
