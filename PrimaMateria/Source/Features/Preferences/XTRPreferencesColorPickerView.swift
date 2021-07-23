//
//  XTRPreferencesColorPickerView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/21/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct XTRPreferencesColorPickerView: View {
    
    @EnvironmentObject var environment: ColorPickerEnvironment
    @State private var red: Double = 0
    @State private var green: Double = 0
    @State private var blue: Double = 0
    @State private var alpha: Double = 0
    @State private var isPresented = false
    
    var body: some View {
        VStack(spacing: 0) {
            Text(NSLocalizedString(environment.seriesIdentifier!, comment: "Series Identifier"))
                .frame(width: XTRPreferencesViewControllerConfig.preferredContentSize.width, height: 48, alignment: .center)
                .font(.system(size: 32, weight: .bold))
                .background(Color(XTRColorFactory.titleBarBackgroundColor))
                .foregroundColor(Color(XTRColorFactory.titleBarTextColor))
            
            Spacer()
                .frame(width: XTRPreferencesViewControllerConfig.preferredContentSize.width, height: 35, alignment: .center)
                .background(Color(environment.seriesColor!))
            
            HStack(spacing: 0) {
                XTRFormTitleView(labelText: NSLocalizedString("red", comment: "Red"), width: 100, height: 21)
                Slider(value: $red, in: 0.0...1.0, onEditingChanged: { _ in
                    updateColorFromSlider()
                })
            }
            .frame(width: XTRPreferencesViewControllerConfig.preferredContentSize.width - 5, height: 36, alignment: .center)
            
            HStack(spacing: 0) {
                XTRFormTitleView(labelText: NSLocalizedString("green", comment: "Green"), width: 100, height: 21)
                    .font(.system(size: 17, weight: .bold))
                Slider(value: $green, in: 0.0...1.0, onEditingChanged: { _ in
                    updateColorFromSlider()
                })
            }
            .frame(width: XTRPreferencesViewControllerConfig.preferredContentSize.width - 5, height: 36, alignment: .center)
            
            HStack(spacing: 0) {
                XTRFormTitleView(labelText: NSLocalizedString("blue", comment: "Blue"), width: 100, height: 21)
                    .font(.system(size: 17, weight: .bold))
                Slider(value: $blue, in: 0.0...1.0, onEditingChanged: { _ in
                    updateColorFromSlider()
                })
            }
            .frame(width: XTRPreferencesViewControllerConfig.preferredContentSize.width - 5, height: 36, alignment: .center)
            
            HStack(spacing: 0) {
                XTRFormTitleView(labelText: NSLocalizedString("alpha", comment: "Alpha"), width: 100, height: 21)
                    .font(.system(size: 17, weight: .bold))
                Slider(value: $alpha, in: 0.0...1.0, onEditingChanged: { _ in
                    updateColorFromSlider()
                })
            }
            .frame(width: XTRPreferencesViewControllerConfig.preferredContentSize.width - 5, height: 36, alignment: .center)
            
            XTRBaseButton(action: {
                self.selectColor()
                self.isPresented.toggle()
            }, labelText: NSLocalizedString("chooseColor", comment: "Choose Color"), width: XTRPreferencesViewControllerConfig.preferredContentSize.width - 10, height: 32, backgroundColor: Color(XTRColorFactory.labelColor))
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
        
        NotificationCenter.default.post(name: .colorSelectedNotification, object: dict)
    }
    
}

struct XTRColorPickerView_Previews: PreviewProvider {
    
    static var previews: some View {
        XTRPreferencesColorPickerView().environmentObject(ColorPickerEnvironment(seriesIdentifier: NSLocalizedString("actinide", comment: "Series Identifier"), seriesColor: XTRColorFactory.defaultActinideColor))
            .previewLayout(.fixed(width: XTRPreferencesViewControllerConfig.preferredContentSize.width, height: XTRPreferencesViewControllerConfig.preferredContentSize.height))
    }
    
}
