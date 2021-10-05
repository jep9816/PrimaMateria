//
//  XTRElementListSupportViews.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 9/10/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct SUIElementHeaderButton: View {
    @State private var showingAlert = false
    
    var title: String
    var width: CGFloat
    
    var body: some View {
        Button(action: {
            self.showingAlert.toggle()
            // swiftlint:disable multiple_closures_with_trailing_closure
        }) {
            Text(title)
                .foregroundColor(Color.white)
            // swiftlint:disable colon
                .frame(width: width, height: SUEElementListViewConfig.HEADER_ROW_HEIGHT, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .border(Color.white, width: 1)
                .font(XTRFontFactory.system14)
        }
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text(title), message: Text("Test"), dismissButton: .default(Text("OK")))
        })
    }
    
}

struct SUIElementHeaderRow: View {
    
    var body: some View {
        HStack(spacing: 0) {
            Group {
                SUIElementHeaderButton(title: NSLocalizedString("elementListNumber", comment: "Number"), width: SUEElementListViewConfig.ATOMIC_NUMBER_BUTTON_WIDTH)
                SUIElementHeaderButton(title: NSLocalizedString("elementListSymbol", comment: "Symbol"), width: SUEElementListViewConfig.SYMBOL_BUTTON_WIDTH)
                SUIElementHeaderButton(title: NSLocalizedString("elementListName", comment: "Name"), width: SUEElementListViewConfig.NAME_BUTTON_WIDTH)
                SUIElementHeaderButton(title: NSLocalizedString("elementListAtomicMass", comment: "Atomic Mass"), width: SUEElementListViewConfig.ATOMIC_MASS_BUTTON_WIDTH)
                SUIElementHeaderButton(title: NSLocalizedString("elementListBoilingPoint", comment: "Boiling Point"), width: SUEElementListViewConfig.BOILING_POINT_BUTTON_WIDTH)
            }
            Group {
                SUIElementHeaderButton(title: NSLocalizedString("elementListMeltingPoint", comment: "Melting Point"), width: SUEElementListViewConfig.MELTING_POINT_BUTTON_WIDTH)
                SUIElementHeaderButton(title: NSLocalizedString("elementListDensity", comment: "Density"), width: SUEElementListViewConfig.DENSITY_BUTTON_WIDTH)
                SUIElementHeaderButton(title: NSLocalizedString("elementListSeries", comment: "Series"), width: SUEElementListViewConfig.SERIES_BUTTON_WIDTH)
                SUIElementHeaderButton(title: NSLocalizedString("elementListPeriod", comment: "Period"), width: SUEElementListViewConfig.PERIOD_BUTTON_WIDTH)
                SUIElementHeaderButton(title: NSLocalizedString("elementListGroup", comment: "Group"), width: SUEElementListViewConfig.GROUP_BUTTON_WIDTH)
            }
        }
        .background(Color.gray)
    }
}

struct SUIElementHeaderRow_Previews: PreviewProvider {
    
    static var previews: some View {
        SUIElementHeaderRow().previewLayout(.fixed(width: 1024, height: 768)) // 9.7
                                                                              //ElementHeaderRow().previewLayout(.fixed(width: 2732 / 2, height: 2048 / 2)) // iPad pro
    }
    
}

struct SUIElementProperyColumn: View {
    
    var property: String
    var width: CGFloat
    var alignment: Alignment
    
    var body: some View {
        Text(property)
            .frame(width: width, height: SUEElementListViewConfig.ELEMENT_ROW_HEIGHT, alignment: alignment)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
            .font(XTRFontFactory.system14)
    }
}

struct SUIElementPropertiesRow: View {
    var element: XTRElementModel
    @State private var isPresented = false
    
    var body: some View {
        HStack(spacing: 0) {
            Group {
                SUIElementProperyColumn(property: "\(element.atomicNumber) ", width: SUEElementListViewConfig.ATOMIC_NUMBER_BUTTON_WIDTH, alignment: .trailing)
                SUIElementProperyColumn(property: element.symbol!, width: SUEElementListViewConfig.SYMBOL_BUTTON_WIDTH, alignment: .center)
                SUIElementProperyColumn(property: " \(element.name!)", width: SUEElementListViewConfig.NAME_BUTTON_WIDTH, alignment: .leading)
                SUIElementProperyColumn(property: "\(element.atomicMass) ", width: SUEElementListViewConfig.ATOMIC_MASS_BUTTON_WIDTH, alignment: .trailing)
                SUIElementProperyColumn(property: "\(element.boilingPoint) ", width: SUEElementListViewConfig.BOILING_POINT_BUTTON_WIDTH, alignment: .trailing)
            }
            
            Group {
                SUIElementProperyColumn(property: "\(element.meltingPoint) ", width: SUEElementListViewConfig.MELTING_POINT_BUTTON_WIDTH, alignment: .trailing)
                SUIElementProperyColumn(property: "\(element.density) ", width: SUEElementListViewConfig.DENSITY_BUTTON_WIDTH, alignment: .trailing)
                SUIElementProperyColumn(property: element.series!, width: SUEElementListViewConfig.SERIES_BUTTON_WIDTH, alignment: .center)
                SUIElementProperyColumn(property: element.period!, width: SUEElementListViewConfig.PERIOD_BUTTON_WIDTH, alignment: .center)
                SUIElementProperyColumn(property: "\(element.group!)", width: SUEElementListViewConfig.GROUP_BUTTON_WIDTH, alignment: .center)
            }
        }
        .background(Color(element.seriesColor))
        .onTapGesture {
            isPresented.toggle()
        }
        .fullScreenCover(isPresented: $isPresented) {
            NavigationView {
                SUIElementInspectorView().environmentObject(SUIElementBallonEnvironment(element: element))
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
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
        
    }
    
}
