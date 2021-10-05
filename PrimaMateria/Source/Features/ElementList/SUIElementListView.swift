//
//  SUIElementListView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 9/10/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct SUEElementListViewConfig {
    
    static let ATOMIC_NUMBER_BUTTON_WIDTH: CGFloat = (88 * UIScreen.main.bounds.width) / 1024
    static let SYMBOL_BUTTON_WIDTH: CGFloat = (94 * UIScreen.main.bounds.width) / 1024
    static let NAME_BUTTON_WIDTH: CGFloat = (121 * UIScreen.main.bounds.width) / 1024
    static let ATOMIC_MASS_BUTTON_WIDTH: CGFloat = (107 * UIScreen.main.bounds.width) / 1024
    static let BOILING_POINT_BUTTON_WIDTH: CGFloat = (107 * UIScreen.main.bounds.width) / 1024
    static let MELTING_POINT_BUTTON_WIDTH: CGFloat = (107 * UIScreen.main.bounds.width) / 1024
    static let DENSITY_BUTTON_WIDTH: CGFloat = (107 * UIScreen.main.bounds.width) / 1024
    static let SERIES_BUTTON_WIDTH: CGFloat = (144 * UIScreen.main.bounds.width) / 1024
    static let PERIOD_BUTTON_WIDTH: CGFloat = (77 * UIScreen.main.bounds.width) / 1024
    static let GROUP_BUTTON_WIDTH: CGFloat = (70 * UIScreen.main.bounds.width) / 1024
    
    static let HEADER_ROW_HEIGHT: CGFloat = 45.0
    static let ELEMENT_ROW_HEIGHT: CGFloat = 44.0
    
}

struct SUIElementListView: View {
    
    private var elementList = XTRDataSource.sharedInstance.elementList
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(XTRColorFactory.backgroundColor)
                    .ignoresSafeArea()
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .center, spacing: 0) {
                        SUIElementHeaderRow()
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(elementList) { element in
                                    SUIElementPropertiesRow(element: element)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(NSLocalizedString("elementList", comment: "Element List"), displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SUIElementListView_Previews: PreviewProvider {
    
    static var previews: some View {
        SUIElementListView().previewLayout(.fixed(width: 1024, height: 768)) // 9.7
        SUIElementListView().previewLayout(.fixed(width: 2732 / 2, height: 2048 / 2)) // iPad pro
    }
    
}
