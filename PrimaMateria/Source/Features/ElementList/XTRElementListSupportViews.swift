//
//  XTRElementListSupportViews.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 9/10/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct ElementHeaderButton: View {
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
            .frame(width: width, height: XTRElementListViewConfig.HEADER_ROW_HEIGHT, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .border(Color.white, width: 1)
            .font(XTRFontFactory.system14)
        }
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text(title), message: Text("Test"), dismissButton: .default(Text("OK")))
        })
    }

}

struct ElementHeaderRow: View {
    
    var body: some View {
        HStack(spacing: 0) {
            Group {
                ElementHeaderButton(title: NSLocalizedString("elementListNumber", comment: "Number"), width: XTRElementListViewConfig.ATOMIC_NUMBER_BUTTON_WIDTH)
                ElementHeaderButton(title: NSLocalizedString("elementListSymbol", comment: "Symbol"), width: XTRElementListViewConfig.SYMBOL_BUTTON_WIDTH)
                ElementHeaderButton(title: NSLocalizedString("elementListName", comment: "Name"), width: XTRElementListViewConfig.NAME_BUTTON_WIDTH)
                ElementHeaderButton(title: NSLocalizedString("elementListAtomicMass", comment: "Atomic Mass"), width: XTRElementListViewConfig.ATOMIC_MASS_BUTTON_WIDTH)
                ElementHeaderButton(title: NSLocalizedString("elementListBoilingPoint", comment: "Boiling Point"), width: XTRElementListViewConfig.BOILING_POINT_BUTTON_WIDTH)
            }
            Group {
                ElementHeaderButton(title: NSLocalizedString("elementListMeltingPoint", comment: "Melting Point"), width: XTRElementListViewConfig.MELTING_POINT_BUTTON_WIDTH)
                ElementHeaderButton(title: NSLocalizedString("elementListDensity", comment: "Density"), width: XTRElementListViewConfig.DENSITY_BUTTON_WIDTH)
                ElementHeaderButton(title: NSLocalizedString("elementListSeries", comment: "Series"), width: XTRElementListViewConfig.SERIES_BUTTON_WIDTH)
                ElementHeaderButton(title: NSLocalizedString("elementListPeriod", comment: "Period"), width: XTRElementListViewConfig.PERIOD_BUTTON_WIDTH)
                ElementHeaderButton(title: NSLocalizedString("elementListGroup", comment: "Group"), width: XTRElementListViewConfig.GROUP_BUTTON_WIDTH)
            }
        }
        .background(Color.gray)
    }
}

struct ElementHeaderRow_Previews: PreviewProvider {
    
    static var previews: some View {
        ElementHeaderRow().previewLayout(.fixed(width: 1024, height: 768)) // 9.7
        //ElementHeaderRow().previewLayout(.fixed(width: 2732 / 2, height: 2048 / 2)) // iPad pro
    }
    
}

struct ElementProperyColumn: View {
    
    var property: String
    var width: CGFloat
    var alignment: Alignment

    var body: some View {
        Text(property)
            .frame(width: width, height: XTRElementListViewConfig.ELEMENT_ROW_HEIGHT, alignment: alignment)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
            .font(XTRFontFactory.system14)
    }
}

struct ElementPropertiesRow: View {
    var element: XTRElementModel
    
    var body: some View {
        HStack(spacing: 0) {
            Group {
                ElementProperyColumn(property: "\(element.atomicNumber) ", width: XTRElementListViewConfig.ATOMIC_NUMBER_BUTTON_WIDTH, alignment: .trailing)
                ElementProperyColumn(property: element.symbol!, width: XTRElementListViewConfig.SYMBOL_BUTTON_WIDTH, alignment: .center)
                ElementProperyColumn(property: " \(element.name!)", width: XTRElementListViewConfig.NAME_BUTTON_WIDTH, alignment: .leading)
                ElementProperyColumn(property: "\(element.atomicMass) ", width: XTRElementListViewConfig.ATOMIC_MASS_BUTTON_WIDTH, alignment: .trailing)
                ElementProperyColumn(property: "\(element.boilingPoint) ", width: XTRElementListViewConfig.BOILING_POINT_BUTTON_WIDTH, alignment: .trailing)
            }
            
            Group {
                ElementProperyColumn(property: "\(element.meltingPoint) ", width: XTRElementListViewConfig.MELTING_POINT_BUTTON_WIDTH, alignment: .trailing)
                ElementProperyColumn(property: "\(element.density) ", width: XTRElementListViewConfig.DENSITY_BUTTON_WIDTH, alignment: .trailing)
                ElementProperyColumn(property: element.series!, width: XTRElementListViewConfig.SERIES_BUTTON_WIDTH, alignment: .center)
                ElementProperyColumn(property: element.period!, width: XTRElementListViewConfig.PERIOD_BUTTON_WIDTH, alignment: .center)
                ElementProperyColumn(property: "\(element.group!)", width: XTRElementListViewConfig.GROUP_BUTTON_WIDTH, alignment: .center)
            }
        }
        .background(Color(element.seriesColor))
    }
    
}
