//
//  XTRPreferencesSeriesColorsView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/22/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct ColorMapper {
    
    @State var foreGroundColor = Color.white
    @State var backGroundColor = Color.black
    
}
struct XTRPreferencesSeriesColorsView: View {
    
    @State var seriesActinideMapper = ColorMapper()
    @State var seriesAlkaliEarthMetalMapper = ColorMapper()
    @State var seriesAlkaliMetalMapper = ColorMapper()
    @State var seriesHalogenMapper = ColorMapper()
    @State var seriesLanthanideMapper = ColorMapper()
    @State var seriesMetalMapper = ColorMapper()
    @State var seriesNobleGasMapper = ColorMapper()
    @State var seriesNonMetalMapper = ColorMapper()
    @State var seriesTransactinidesMapper = ColorMapper()
    @State var seriesTransitionMetalMapper = ColorMapper()
    
    var body: some View {
        HStack(spacing: 5) {
            VStack(spacing: 5) {
                Text(NSLocalizedString("seriesColors", comment: "Series Colors"))
                    .font(.system(size: 18, weight: .regular))
                Group {
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("actinide", comment: "Actinide"), width: 230, height: 32, backgroundColor: seriesActinideMapper.backGroundColor)
                        .foregroundColor(seriesActinideMapper.foreGroundColor)
                    
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("alkaliEarthMetal", comment: "Alkali Earth Metal"), width: 230, height: 32, backgroundColor: seriesAlkaliEarthMetalMapper.backGroundColor)
                        .foregroundColor(seriesAlkaliEarthMetalMapper.foreGroundColor)
                    
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("alkaliMetal", comment: "Alkali Metal"), width: 230, height: 32, backgroundColor: seriesAlkaliMetalMapper.backGroundColor)
                        .foregroundColor(seriesAlkaliMetalMapper.foreGroundColor)
                    
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("halogen", comment: "Halogen"), width: 230, height: 32, backgroundColor: seriesHalogenMapper.backGroundColor)
                        .foregroundColor(seriesHalogenMapper.foreGroundColor)
                    
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("lanthanide", comment: "Lanthanide"), width: 230, height: 32, backgroundColor: seriesLanthanideMapper.backGroundColor)
                        .foregroundColor(seriesLanthanideMapper.foreGroundColor)
                }
                .background(Color(XTRColorFactory.tableViewCellBorderColor))
                Group {
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("metal", comment: "Metal"), width: 230, height: 32, backgroundColor: seriesMetalMapper.backGroundColor)
                        .foregroundColor(seriesMetalMapper.foreGroundColor)
                    
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("nobleGas", comment: "NobleGas"), width: 230, height: 32, backgroundColor: seriesNobleGasMapper.backGroundColor)
                        .foregroundColor(seriesNobleGasMapper.foreGroundColor)
                    
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("nonMetal", comment: "Non Metal"), width: 230, height: 32, backgroundColor: seriesNonMetalMapper.backGroundColor)
                        .foregroundColor(seriesNonMetalMapper.foreGroundColor)
                    
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("transactinide", comment: "Transactinide"), width: 230, height: 32, backgroundColor: seriesTransactinidesMapper.backGroundColor)
                        .foregroundColor(seriesTransactinidesMapper.foreGroundColor)
                    
                    XTRBaseButton(action: {}, labelText: NSLocalizedString("transitionMetal", comment: "Transition Metal"), width: 230, height: 32, backgroundColor: seriesTransitionMetalMapper.backGroundColor)
                        .foregroundColor(seriesTransitionMetalMapper.foreGroundColor)
                }
                .background(Color(XTRColorFactory.tableViewCellBorderColor))
            }
            
            .background(Color(XTRColorFactory.tableViewCellBorderColor))
        }
        .onAppear(perform: {
            populateSeriesColors()
        })
    }
    
    func populateSeriesColors() {
        seriesActinideMapper = ColorMapper(foreGroundColor: Color(XTRColorFactory.actinideColor), backGroundColor: Color(XTRColorFactory.actinideColor.inverseColor()))

        seriesAlkaliEarthMetalMapper = ColorMapper(foreGroundColor: Color(XTRColorFactory.alkaliEarthMetalColor), backGroundColor: Color(XTRColorFactory.alkaliEarthMetalColor.inverseColor()))
        
        seriesAlkaliMetalMapper = ColorMapper(foreGroundColor: Color(XTRColorFactory.alkaliMetalColor), backGroundColor: Color(XTRColorFactory.alkaliMetalColor.inverseColor()))
        
        seriesHalogenMapper = ColorMapper(foreGroundColor: Color(XTRColorFactory.halogenColor), backGroundColor: Color(XTRColorFactory.halogenColor.inverseColor()))
        
        seriesLanthanideMapper = ColorMapper(foreGroundColor: Color(XTRColorFactory.lanthanideColor), backGroundColor: Color(XTRColorFactory.lanthanideColor.inverseColor()))
        
        seriesMetalMapper = ColorMapper(foreGroundColor: Color(XTRColorFactory.metalColor), backGroundColor: Color(XTRColorFactory.metalColor.inverseColor()))
        
        seriesNobleGasMapper = ColorMapper(foreGroundColor: Color(XTRColorFactory.nobleGasColor), backGroundColor: Color(XTRColorFactory.nobleGasColor.inverseColor()))
        
        seriesNonMetalMapper = ColorMapper(foreGroundColor: Color(XTRColorFactory.nonMetalColor), backGroundColor: Color(XTRColorFactory.nonMetalColor.inverseColor()))
        
        seriesTransactinidesMapper = ColorMapper(foreGroundColor: Color(XTRColorFactory.transactinideColor), backGroundColor: Color(XTRColorFactory.transactinideColor.inverseColor()))
        
        seriesTransitionMetalMapper = ColorMapper(foreGroundColor: Color(XTRColorFactory.transitionMetalColor), backGroundColor: Color(XTRColorFactory.transitionMetalColor.inverseColor()))
    }

}

struct XTRPreferencesSeriesColorsView_Previews: PreviewProvider {
    
    static var previews: some View {
        XTRPreferencesSeriesColorsView().previewLayout(.fixed(width: 1024, height: 768))
    }
    
}
