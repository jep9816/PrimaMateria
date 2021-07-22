//
//  XTRPreferencesSeriesColorsView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/22/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct XTRPreferencesSeriesColorsView: View {
    
    var body: some View {
        HStack(spacing: 5) {
            VStack(spacing: 5) {
                Text(NSLocalizedString("seriesColors", comment: "Series Colors"))
                    .font(.system(size: 18, weight: .regular))
                Group {
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("actinide", comment: "Actinide"), width: 230, height: 32, backgroundColor: Color.black)
                    
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("alkaliEarthMetal", comment: "Alkali Earth Metal"), width: 230, height: 32, backgroundColor: Color.black)
                    
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("alkaliMetal", comment: "Alkali Metal"), width: 230, height: 32, backgroundColor: Color.black)
                    
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("halogen", comment: "Halogen"), width: 230, height: 32, backgroundColor: Color.black)
                    
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("lanthanide", comment: "Lanthanide"), width: 230, height: 32, backgroundColor: Color.black)
                }
                .background(Color(XTRColorFactory.tableViewCellBorderColor))
                Group {
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("metal", comment: "Metal"), width: 230, height: 32, backgroundColor: Color.black)
                    
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("nobleGas", comment: "NobleGas"), width: 230, height: 32, backgroundColor: Color.black)
                    
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("nonMetal", comment: "Non Metal"), width: 230, height: 32, backgroundColor: Color.black)
                    
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("transactinide", comment: "Transactinide"), width: 230, height: 32, backgroundColor: Color.black)
                    
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("transitionMetal", comment: "Transition Metal"), width: 230, height: 32, backgroundColor: Color.black)
                }
                .background(Color(XTRColorFactory.tableViewCellBorderColor))
            }
            
            .background(Color(XTRColorFactory.tableViewCellBorderColor))
        }
    }
    
}

struct XTRPreferencesSeriesColorsView_Previews: PreviewProvider {
    
    static var previews: some View {
        XTRPreferencesSeriesColorsView().previewLayout(.fixed(width: 1024, height: 768))
    }
    
}
