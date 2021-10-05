//
//  SUIPreferencesColorPickerView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/21/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct SUIPreferencesColorPickerView: View {
    
    @EnvironmentObject var environment: SUIColorPickerEnvironment
    @Environment(\.presentationMode) var presentationMode

    @State private var red: Double = 0
    @State private var green: Double = 0
    @State private var blue: Double = 0
    @State private var alpha: Double = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Text(NSLocalizedString(environment.seriesIdentifier!, comment: "Series Identifier"))
                .frame(width: SUIPreferencesViewConfig.preferredContentSize.width, height: 48, alignment: .center)
                .font(XTRFontFactory.boldSystem32)
                .background(Color(XTRColorFactory.titleBarBackgroundColor))
                .foregroundColor(Color(XTRColorFactory.titleBarTextColor))
            
            Spacer()
                .frame(width: SUIPreferencesViewConfig.preferredContentSize.width, height: 35, alignment: .center)
                .background(Color(environment.seriesColor!))
            
            HStack(spacing: 0) {
                SUIFormTitleView(labelText: NSLocalizedString("red", comment: "Red"), width: 100, height: 21)
                Slider(value: $red, in: 0.0...1.0, onEditingChanged: { _ in
                    updateColorFromSlider()
                })
            }
            .frame(width: SUIPreferencesViewConfig.preferredContentSize.width - 5, height: 36, alignment: .center)
            
            HStack(spacing: 0) {
                SUIFormTitleView(labelText: NSLocalizedString("green", comment: "Green"), width: 100, height: 21)
                    .font(XTRFontFactory.boldSystem17)
                Slider(value: $green, in: 0.0...1.0, onEditingChanged: { _ in
                    updateColorFromSlider()
                })
            }
            .frame(width: SUIPreferencesViewConfig.preferredContentSize.width - 5, height: 36, alignment: .center)
            
            HStack(spacing: 0) {
                SUIFormTitleView(labelText: NSLocalizedString("blue", comment: "Blue"), width: 100, height: 21)
                    .font(XTRFontFactory.boldSystem17)
                Slider(value: $blue, in: 0.0...1.0, onEditingChanged: { _ in
                    updateColorFromSlider()
                })
            }
            .frame(width: SUIPreferencesViewConfig.preferredContentSize.width - 5, height: 36, alignment: .center)
            
            HStack(spacing: 0) {
                SUIFormTitleView(labelText: NSLocalizedString("alpha", comment: "Alpha"), width: 100, height: 21)
                    .font(XTRFontFactory.boldSystem17)
                Slider(value: $alpha, in: 0.0...1.0, onEditingChanged: { _ in
                    updateColorFromSlider()
                })
            }
            .frame(width: SUIPreferencesViewConfig.preferredContentSize.width - 5, height: 36, alignment: .center)
            
            SUIBaseButton(action: {
                self.selectColor()
                presentationMode.wrappedValue.dismiss()
            }, labelText: NSLocalizedString("chooseColor", comment: "Choose Color"), width: SUIPreferencesViewConfig.preferredContentSize.width - 10, height: 32, backgroundColor: Color(XTRColorFactory.labelColor))
        }
        .background(Color(XTRColorFactory.rowColor))
        .onAppear(perform: {
            presetSlidersWithColor(environment.seriesColor!)
        })
    }
    
    func presetSlidersWithColor(_ aColor: UIColor) {
        red = Double(environment.seriesColor!.red())
        green = Double(environment.seriesColor!.green())
        blue = Double(environment.seriesColor!.blue())
        alpha = Double(environment.seriesColor!.alpha())
    }
    
    func updateColorFromSlider() {
        let color = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
        environment.seriesColor = color
    }
    
    func selectColor() {
        let dict = zip(
            [
                ColorComponent.red,
                ColorComponent.green,
                ColorComponent.blue,
                ColorComponent.alpha,
                SERIES_IDENTIFIER_KEY
            ], [
                CGFloat(red),
                CGFloat(green),
                CGFloat(blue),
                CGFloat(alpha),
                environment.seriesIdentifier!
            ]).reduce([String: Any]()) {
                var prop = $0
                prop[$1.0] = $1.1
                return prop
            }
        
        let color = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
        let colorData = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
        
        XTRPropertiesStore.setColorData(colorData, key: environment.seriesIdentifier!)
        
        NotificationCenter.default.post(name: .colorSelectedNotification, object: dict)
    }
    
}

struct SUIColorPickerView_Previews: PreviewProvider {
    
    static var previews: some View {
        SUIPreferencesColorPickerView().environmentObject(SUIColorPickerEnvironment(seriesIdentifier: NSLocalizedString("actinide", comment: "Series Identifier"), seriesColor: XTRColorFactory.defaultActinideColor))
            .previewLayout(.fixed(width: SUIPreferencesViewConfig.preferredContentSize.width, height: SUIPreferencesViewConfig.preferredContentSize.height))
    }
    
}
