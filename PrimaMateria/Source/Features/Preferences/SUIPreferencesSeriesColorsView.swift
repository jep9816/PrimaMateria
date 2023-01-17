//
//  SUIPreferencesSeriesColorsView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/22/21.
//  Copyright ©2023 Jerry Porter. All rights reserved.
//

import SwiftUI

struct SUIPreferencesSeriesColorsView: View {
    
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
    let pub = NotificationCenter.default.publisher(for: .colorSelectedNotification)

    @State var showingPopover: [Bool] = [false, false, false, false, false, false, false, false, false, false]

    var body: some View {
        HStack(spacing: 5) {
            VStack(spacing: 5) {
                Text(NSLocalizedString("seriesColors", comment: "Series Colors"))
                    .font(XTRFontFactory.regularSystem18)
                Group {
                    SUIBaseButton(action: {
                        resetPopoverForPosition(0)
                    }, labelText: NSLocalizedString(ElementSeries.actinide, comment: "Actinide"), width: 230, height: 32, backgroundColor: Color(seriesActinideMapper.backGroundColor))
                    .foregroundColor(Color(seriesActinideMapper.foreGroundColor))
                    .popover(isPresented: $showingPopover[0]) {
                        self.presentColorPicker(ElementSeries.actinide)
                    }
                    
                    SUIBaseButton(action: {
                        resetPopoverForPosition(1)
                    }, labelText: NSLocalizedString(ElementSeries.alkaliEarthMetal, comment: "Alkali Earth Metal"), width: 230, height: 32, backgroundColor: Color(seriesAlkaliEarthMetalMapper.backGroundColor))
                        .foregroundColor(Color(seriesAlkaliEarthMetalMapper.foreGroundColor))
                        .popover(isPresented: $showingPopover[1]) {
                            self.presentColorPicker(ElementSeries.alkaliEarthMetal)
                        }

                    SUIBaseButton(action: {
                        resetPopoverForPosition(2)
                    }, labelText: NSLocalizedString(ElementSeries.alkaliMetal, comment: "Alkali Metal"), width: 230, height: 32, backgroundColor: Color(seriesAlkaliMetalMapper.backGroundColor))
                        .foregroundColor(Color(seriesAlkaliMetalMapper.foreGroundColor))
                        .popover(isPresented: $showingPopover[2]) {
                            self.presentColorPicker(ElementSeries.alkaliMetal)
                        }
                    SUIBaseButton(action: {
                        resetPopoverForPosition(3)
                    }, labelText: NSLocalizedString(ElementSeries.halogen, comment: "Halogen"), width: 230, height: 32, backgroundColor: Color(seriesHalogenMapper.backGroundColor))
                        .foregroundColor(Color(seriesHalogenMapper.foreGroundColor))
                        .popover(isPresented: $showingPopover[3]) {
                            self.presentColorPicker(ElementSeries.halogen)
                        }
                    
                    SUIBaseButton(action: {
                        resetPopoverForPosition(4)
                    }, labelText: NSLocalizedString(ElementSeries.lanthanide, comment: "Lanthanide"), width: 230, height: 32, backgroundColor: Color(seriesLanthanideMapper.backGroundColor))
                        .foregroundColor(Color(seriesLanthanideMapper.foreGroundColor))
                        .popover(isPresented: $showingPopover[4]) {
                            self.presentColorPicker(ElementSeries.lanthanide)
                        }
                }
                .background(Color(XTRColorFactory.tableViewCellBorderColor))
                
                Group {
                    SUIBaseButton(action: {
                        resetPopoverForPosition(5)
                    }, labelText: NSLocalizedString(ElementSeries.metal, comment: "Metal"), width: 230, height: 32, backgroundColor: Color(seriesMetalMapper.backGroundColor))
                        .foregroundColor(Color(seriesMetalMapper.foreGroundColor))
                        .popover(isPresented: $showingPopover[5]) {
                            self.presentColorPicker(ElementSeries.metal)
                        }

                    SUIBaseButton(action: {
                        resetPopoverForPosition(6)
                    }, labelText: NSLocalizedString(ElementSeries.nobleGas, comment: "NobleGas"), width: 230, height: 32, backgroundColor: Color(seriesNobleGasMapper.backGroundColor))
                        .foregroundColor(Color(seriesNobleGasMapper.foreGroundColor))
                        .popover(isPresented: $showingPopover[6]) {
                            self.presentColorPicker(ElementSeries.nobleGas)
                        }

                    SUIBaseButton(action: {
                        resetPopoverForPosition(7)
                    }, labelText: NSLocalizedString(ElementSeries.nonMetal, comment: "Non Metal"), width: 230, height: 32, backgroundColor: Color(seriesNonMetalMapper.backGroundColor))
                        .foregroundColor(Color(seriesNonMetalMapper.foreGroundColor))
                        .popover(isPresented: $showingPopover[7]) {
                            self.presentColorPicker(ElementSeries.nonMetal)
                        }

                    SUIBaseButton(action: {
                        resetPopoverForPosition(8)
                    }, labelText: NSLocalizedString(ElementSeries.transactinide, comment: "Transactinide"), width: 230, height: 32, backgroundColor: Color(seriesTransactinidesMapper.backGroundColor))
                        .foregroundColor(Color(seriesTransactinidesMapper.foreGroundColor))
                        .popover(isPresented: $showingPopover[8]) {
                            self.presentColorPicker(ElementSeries.transactinide)
                        }

                    SUIBaseButton(action: {
                        resetPopoverForPosition(9)
                    }, labelText: NSLocalizedString(ElementSeries.transitionMetal, comment: "Transition Metal"), width: 230, height: 32, backgroundColor: Color(seriesTransitionMetalMapper.backGroundColor))
                        .foregroundColor(Color(seriesTransitionMetalMapper.foreGroundColor))
                        .popover(isPresented: $showingPopover[9]) {
                            self.presentColorPicker(ElementSeries.transitionMetal)
                        }
                }
                .background(Color(XTRColorFactory.tableViewCellBorderColor))
            }
            .background(Color(XTRColorFactory.tableViewCellBorderColor))
        }
        .onAppear(perform: {
            populateSeriesColors()
        })
        .onReceive(pub) { _ in
            populateSeriesColors()
        }
    }
    
    func resetPopoverForPosition(_ position: Int) {
        for index in 0 ..< showingPopover.count {
            showingPopover[index] = false
        }
        showingPopover[position] = true
    }
    
    func presentColorPicker(_ seriesIdentifier: String) -> some View {
        return SUIPreferencesColorPickerView().environmentObject(SUIColorPickerEnvironment(seriesIdentifier: seriesIdentifier, seriesColor: XTRColorFactory.colorForString(seriesIdentifier)))
    }

    func updateSeriesProperties(_ button: UIButton, color: UIColor) {
        button.backgroundColor = color
        button.setTitleColor(color.inverseColor(), for: UIControl.State())
    }

    func populateSeriesColors() {
        seriesActinideMapper = ColorMapper(foreGroundColor: XTRColorFactory.actinideColor.inverseColor(), backGroundColor: XTRColorFactory.actinideColor)
        
        seriesAlkaliEarthMetalMapper = ColorMapper(foreGroundColor: XTRColorFactory.alkaliEarthMetalColor.inverseColor(), backGroundColor: XTRColorFactory.alkaliEarthMetalColor)
        
        seriesAlkaliMetalMapper = ColorMapper(foreGroundColor: XTRColorFactory.alkaliMetalColor.inverseColor(), backGroundColor: XTRColorFactory.alkaliMetalColor)
        
        seriesHalogenMapper = ColorMapper(foreGroundColor: XTRColorFactory.halogenColor.inverseColor(), backGroundColor: XTRColorFactory.halogenColor)
        
        seriesLanthanideMapper = ColorMapper(foreGroundColor: XTRColorFactory.lanthanideColor.inverseColor(), backGroundColor: XTRColorFactory.lanthanideColor)
        
        seriesMetalMapper = ColorMapper(foreGroundColor: XTRColorFactory.metalColor.inverseColor(), backGroundColor: XTRColorFactory.metalColor)
        
        seriesNobleGasMapper = ColorMapper(foreGroundColor: XTRColorFactory.nobleGasColor.inverseColor(), backGroundColor: XTRColorFactory.nobleGasColor)
        
        seriesNonMetalMapper = ColorMapper(foreGroundColor: XTRColorFactory.nonMetalColor.inverseColor(), backGroundColor: XTRColorFactory.nonMetalColor)
        
        seriesTransactinidesMapper = ColorMapper(foreGroundColor: XTRColorFactory.transactinideColor.inverseColor(), backGroundColor: XTRColorFactory.transactinideColor)
        
        seriesTransitionMetalMapper = ColorMapper(foreGroundColor: XTRColorFactory.transitionMetalColor.inverseColor(), backGroundColor: XTRColorFactory.transitionMetalColor)
    }
    
}

struct SUIPreferencesSeriesColorsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SUIPreferencesSeriesColorsView().previewLayout(.fixed(width: 1024, height: 768))
    }
    
}
