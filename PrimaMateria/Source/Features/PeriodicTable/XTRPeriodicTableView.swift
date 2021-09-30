//
//  XTRPeriodicTableView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 9/8/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct XTRPeriodicTableViewConfig {
    
    static let buttonWidth = (50 * UIScreen.main.bounds.width) / 1024
    static let buttonHeight = (50 * UIScreen.main.bounds.width) / 1024
    static let preferredContentHeight: CGFloat = buttonHeight * 12
    static let preferredContentWidth: CGFloat = buttonWidth * 20
    
}

struct XTRPeriodicTableView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(XTRColorFactory.backgroundColor)
                    .ignoresSafeArea()
                VStack(alignment: .leading, spacing: 0, content: {
                    HStack(alignment: .top, spacing: 0, content: {
                        // swiftlint:disable multiple_closures_with_trailing_closure
                        XTRHelpButtonView(helpKey: "periodicTable")
                        .padding(.top)
                        Spacer()
                    })
                    HStack(alignment: .top, spacing: 0, content: {
                        VStack {
                            Spacer()
                                .frame(width: 20, height: 200, alignment: .center)
                            Text("P")
                                .foregroundColor(.white)
                                .font(XTRFontFactory.system17)
                            Text("e")
                                .foregroundColor(.white)
                                .font(XTRFontFactory.system17)
                            Text("r")
                                .foregroundColor(.white)
                                .font(XTRFontFactory.system17)
                            Text("i")
                                .foregroundColor(.white)
                                .font(XTRFontFactory.system17)
                            Text("o")
                                .foregroundColor(.white)
                                .font(XTRFontFactory.system17)
                            Text("d")
                                .foregroundColor(.white)
                                .font(XTRFontFactory.system17)
                        }
                        .frame(width: 20, height: XTRPeriodicTableViewConfig.buttonHeight * 8, alignment: .center)
                        VStack(alignment: .center, spacing: 5) {
                         Text(NSLocalizedString("group", comment: "Group"))
                         .foregroundColor(.white)
                         .font(XTRFontFactory.boldSystem17)
                         .padding()
                         ScrollView {
                         LazyVGrid(columns: gridItemLayout, spacing: 2) {
                         ForEach(0...PeriodicTableLayout.layoutItemModels.count - 1, id: \.self) {
                         let increment = $0
                         let model = PeriodicTableLayout.layoutItemModels[increment]
                         // swiftlint:disable colon
                         VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 1) {
                         switch model.elementType {
                         case "group":
                         GroupLayoutView(model: model)
                         case "groupLeft":
                         GroupLeftLayoutView(model: model)
                         case "groupRight":
                         GroupRightLayoutView(model: model)
                         case "period":
                         PeriodLayoutView(model: model)
                         case "placeholder":
                         PlaceholderLayoutView(model: model)
                         case "seriesLabel":
                         SeriesLabelLayoutView(model: model)
                         default:
                         ButtonLayoutView(model: model)
                         }
                         }
                         }
                         }
                         }
                         .frame(width: XTRPeriodicTableViewConfig.preferredContentWidth, height: XTRPeriodicTableViewConfig.preferredContentHeight).offset(x: 0, y: 0)
                         Spacer()
                         }
                    })
                    Spacer()
                })                
            }
            .navigationBarTitle(NSLocalizedString("periodicTableElements", comment: "Periodic Table"), displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var gridItemLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
}

struct XTRPeriodicTableView_Previews: PreviewProvider {
    
    static var previews: some View {
        XTRPeriodicTableView().previewLayout(.fixed(width: 1024, height: 768)) // 9.7
        XTRPeriodicTableView().previewLayout(.fixed(width: 2732 / 2, height: 2048 / 2)) // iPad pro
    }
    
}

struct LayoutItemModel {
    
    var symbol: String = ""
    var elementNumber: String = ""
    var elementType: String = ""
    
}

struct GroupLayoutView: View {
    
    var model: LayoutItemModel!
    
    var body: some View {
        Text(model.symbol)
            .frame(width: XTRPeriodicTableViewConfig.buttonWidth, height: 20, alignment: .center)
            .foregroundColor(.white)
            .font(XTRFontFactory.system17)
        Text(model.elementNumber)
            .frame(width: XTRPeriodicTableViewConfig.buttonWidth, height: 32, alignment: .center)
            .foregroundColor(.white)
    }
    
}

struct GroupLeftLayoutView: View {
    
    var model: LayoutItemModel!
    
    var body: some View {
        Text(model.symbol)
            .frame(width: XTRPeriodicTableViewConfig.buttonWidth, height: 20, alignment: .center)
            .foregroundColor(.white)
            .font(XTRFontFactory.system17)
        Text(model.elementNumber)
            .frame(width: XTRPeriodicTableViewConfig.buttonWidth, height: 32, alignment: .trailing)
            .foregroundColor(.white)
            .font(XTRFontFactory.system17)
    }
    
}

struct GroupRightLayoutView: View {
    
    var model: LayoutItemModel!
    
    var body: some View {
        Text(model.symbol)
            .frame(width: XTRPeriodicTableViewConfig.buttonWidth, height: 20, alignment: .center)
            .foregroundColor(.white)
            .font(XTRFontFactory.system17)
        Text(model.elementNumber)
            .frame(width: XTRPeriodicTableViewConfig.buttonWidth, height: 32, alignment: .leading)
            .foregroundColor(.white)
            .font(XTRFontFactory.system17)
    }
    
}

struct PeriodLayoutView: View {
    
    var model: LayoutItemModel!
    
    var body: some View {
        Text(model.symbol)
            .frame(width: 22, height: 22, alignment: .trailing)
            .foregroundColor(.white)
            .font(XTRFontFactory.system17)
    }
    
}

struct PlaceholderLayoutView: View {
    
    var model: LayoutItemModel!
    
    var body: some View {
        Text("")
            .frame(width: XTRPeriodicTableViewConfig.buttonWidth, height: XTRPeriodicTableViewConfig.buttonHeight, alignment: .center)
    }
    
}

struct SeriesLabelLayoutView: View {
    
    var model: LayoutItemModel!
    
    var body: some View {
        Text(NSLocalizedString(model.symbol, comment: "Series label"))
            .foregroundColor(.white)
            .frame(width: XTRPeriodicTableViewConfig.buttonWidth * 3, height: XTRPeriodicTableViewConfig.buttonHeight, alignment: .leading)
            .font(XTRFontFactory.system17)
    }
    
}

struct ButtonLayoutView: View {
    
    var model: LayoutItemModel!
    
    var body: some View {
        XTRElementButtonView(action: {}, symbolText: model.symbol, elementNumber: Int(model.elementNumber), width: XTRPeriodicTableViewConfig.buttonWidth, height: XTRPeriodicTableViewConfig.buttonHeight)
    }
    
}

struct PeriodicTableLayout {
    
    static let layoutItemModels = [
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        LayoutItemModel(symbol: "1", elementNumber: "IA", elementType: "group"),
        LayoutItemModel(symbol: "2", elementNumber: "IIA", elementType: "group"),
        LayoutItemModel(symbol: "3", elementNumber: "IIIB", elementType: "group"),
        LayoutItemModel(symbol: "4", elementNumber: "IVB", elementType: "group"),
        LayoutItemModel(symbol: "5", elementNumber: "VB", elementType: "group"),
        LayoutItemModel(symbol: "6", elementNumber: "VIB", elementType: "group"),
        LayoutItemModel(symbol: "7", elementNumber: "VIIB", elementType: "group"),
        LayoutItemModel(symbol: "8", elementNumber: "╠═", elementType: "groupLeft"),
        LayoutItemModel(symbol: "9", elementNumber: "VIIIA", elementType: "group"),
        LayoutItemModel(symbol: "10", elementNumber: "═╣", elementType: "groupRight"),
        LayoutItemModel(symbol: "11", elementNumber: "IB", elementType: "group"),
        LayoutItemModel(symbol: "12", elementNumber: "IIB", elementType: "group"),
        LayoutItemModel(symbol: "13", elementNumber: "IIIA", elementType: "group"),
        LayoutItemModel(symbol: "14", elementNumber: "IVA", elementType: "group"),
        LayoutItemModel(symbol: "15", elementNumber: "VA", elementType: "group"),
        LayoutItemModel(symbol: "16", elementNumber: "VIA", elementType: "group"),
        LayoutItemModel(symbol: "17", elementNumber: "VIIA", elementType: "group"),
        LayoutItemModel(symbol: "18", elementNumber: "VIIIA", elementType: "group"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        LayoutItemModel(symbol: "1", elementNumber: "", elementType: "period"),
        LayoutItemModel(symbol: "H", elementNumber: "1", elementType: "button"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "He", elementNumber: "2", elementType: "button"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        LayoutItemModel(symbol: "2", elementNumber: "", elementType: "period"),
        LayoutItemModel(symbol: "Li", elementNumber: "3", elementType: "button"),
        LayoutItemModel(symbol: "Be", elementNumber: "4", elementType: "button"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "B", elementNumber: "5", elementType: "button"),
        LayoutItemModel(symbol: "C", elementNumber: "6", elementType: "button"),
        LayoutItemModel(symbol: "N", elementNumber: "7", elementType: "button"),
        LayoutItemModel(symbol: "O", elementNumber: "8", elementType: "button"),
        LayoutItemModel(symbol: "F", elementNumber: "9", elementType: "button"),
        LayoutItemModel(symbol: "Ne", elementNumber: "10", elementType: "button"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        LayoutItemModel(symbol: "3", elementNumber: "", elementType: "period"),
        LayoutItemModel(symbol: "Na", elementNumber: "11", elementType: "button"),
        LayoutItemModel(symbol: "Mg", elementNumber: "12", elementType: "button"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "Al", elementNumber: "13", elementType: "button"),
        LayoutItemModel(symbol: "Si", elementNumber: "14", elementType: "button"),
        LayoutItemModel(symbol: "P", elementNumber: "15", elementType: "button"),
        LayoutItemModel(symbol: "S", elementNumber: "16", elementType: "button"),
        LayoutItemModel(symbol: "Cl", elementNumber: "17", elementType: "button"),
        LayoutItemModel(symbol: "Ar", elementNumber: "18", elementType: "button"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        LayoutItemModel(symbol: "4", elementNumber: "", elementType: "period"),
        LayoutItemModel(symbol: "K", elementNumber: "19", elementType: "button"),
        LayoutItemModel(symbol: "Ca", elementNumber: "20", elementType: "button"),
        LayoutItemModel(symbol: "Sc", elementNumber: "21", elementType: "button"),
        LayoutItemModel(symbol: "Ti", elementNumber: "22", elementType: "button"),
        LayoutItemModel(symbol: "V", elementNumber: "23", elementType: "button"),
        LayoutItemModel(symbol: "Cr", elementNumber: "24", elementType: "button"),
        LayoutItemModel(symbol: "Mn", elementNumber: "25", elementType: "button"),
        LayoutItemModel(symbol: "Fe", elementNumber: "26", elementType: "button"),
        LayoutItemModel(symbol: "Co", elementNumber: "26", elementType: "button"),
        LayoutItemModel(symbol: "Ni", elementNumber: "28", elementType: "button"),
        LayoutItemModel(symbol: "Cu", elementNumber: "28", elementType: "button"),
        LayoutItemModel(symbol: "Zn", elementNumber: "30", elementType: "button"),
        LayoutItemModel(symbol: "Ga", elementNumber: "31", elementType: "button"),
        LayoutItemModel(symbol: "Ge", elementNumber: "32", elementType: "button"),
        LayoutItemModel(symbol: "As", elementNumber: "33", elementType: "button"),
        LayoutItemModel(symbol: "Se", elementNumber: "34", elementType: "button"),
        LayoutItemModel(symbol: "Br", elementNumber: "35", elementType: "button"),
        LayoutItemModel(symbol: "Kr", elementNumber: "36", elementType: "button"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        LayoutItemModel(symbol: "5", elementNumber: "", elementType: "period"),
        LayoutItemModel(symbol: "Rb", elementNumber: "37", elementType: "button"),
        LayoutItemModel(symbol: "Sr", elementNumber: "38", elementType: "button"),
        LayoutItemModel(symbol: "Y", elementNumber: "39", elementType: "button"),
        LayoutItemModel(symbol: "Zr", elementNumber: "40", elementType: "button"),
        LayoutItemModel(symbol: "Nb", elementNumber: "41", elementType: "button"),
        LayoutItemModel(symbol: "Mo", elementNumber: "42", elementType: "button"),
        LayoutItemModel(symbol: "Tc", elementNumber: "43", elementType: "button"),
        LayoutItemModel(symbol: "Ru", elementNumber: "44", elementType: "button"),
        LayoutItemModel(symbol: "Rh", elementNumber: "45", elementType: "button"),
        LayoutItemModel(symbol: "Pd", elementNumber: "46", elementType: "button"),
        LayoutItemModel(symbol: "Ag", elementNumber: "47", elementType: "button"),
        LayoutItemModel(symbol: "Cd", elementNumber: "48", elementType: "button"),
        LayoutItemModel(symbol: "In", elementNumber: "49", elementType: "button"),
        LayoutItemModel(symbol: "Sn", elementNumber: "50", elementType: "button"),
        LayoutItemModel(symbol: "Sb", elementNumber: "51", elementType: "button"),
        LayoutItemModel(symbol: "Te", elementNumber: "52", elementType: "button"),
        LayoutItemModel(symbol: "I", elementNumber: "53", elementType: "button"),
        LayoutItemModel(symbol: "Xe", elementNumber: "54", elementType: "button"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        LayoutItemModel(symbol: "6", elementNumber: "", elementType: "period"),
        LayoutItemModel(symbol: "Cs", elementNumber: "55", elementType: "button"),
        LayoutItemModel(symbol: "Ba", elementNumber: "56", elementType: "button"),
        LayoutItemModel(symbol: "La", elementNumber: "57", elementType: "button"),
        LayoutItemModel(symbol: "Hf", elementNumber: "72", elementType: "button"),
        LayoutItemModel(symbol: "Ta", elementNumber: "73", elementType: "button"),
        LayoutItemModel(symbol: "W", elementNumber: "74", elementType: "button"),
        LayoutItemModel(symbol: "Re", elementNumber: "75", elementType: "button"),
        LayoutItemModel(symbol: "Os", elementNumber: "76", elementType: "button"),
        LayoutItemModel(symbol: "Ir", elementNumber: "77", elementType: "button"),
        LayoutItemModel(symbol: "Pt", elementNumber: "78", elementType: "button"),
        LayoutItemModel(symbol: "Au", elementNumber: "79", elementType: "button"),
        LayoutItemModel(symbol: "Hg", elementNumber: "80", elementType: "button"),
        LayoutItemModel(symbol: "Ti", elementNumber: "81", elementType: "button"),
        LayoutItemModel(symbol: "Pb", elementNumber: "82", elementType: "button"),
        LayoutItemModel(symbol: "Bi", elementNumber: "83", elementType: "button"),
        LayoutItemModel(symbol: "Po", elementNumber: "84", elementType: "button"),
        LayoutItemModel(symbol: "At", elementNumber: "85", elementType: "button"),
        LayoutItemModel(symbol: "Rn", elementNumber: "86", elementType: "button"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        LayoutItemModel(symbol: "7", elementNumber: "", elementType: "period"),
        LayoutItemModel(symbol: "Fr", elementNumber: "87", elementType: "button"),
        LayoutItemModel(symbol: "Ra", elementNumber: "88", elementType: "button"),
        LayoutItemModel(symbol: "Ac", elementNumber: "89", elementType: "button"),
        LayoutItemModel(symbol: "Rf", elementNumber: "104", elementType: "button"),
        LayoutItemModel(symbol: "Db", elementNumber: "105", elementType: "button"),
        LayoutItemModel(symbol: "Sg", elementNumber: "106", elementType: "button"),
        LayoutItemModel(symbol: "Bh", elementNumber: "107", elementType: "button"),
        LayoutItemModel(symbol: "Hs", elementNumber: "108", elementType: "button"),
        LayoutItemModel(symbol: "Mt", elementNumber: "109", elementType: "button"),
        LayoutItemModel(symbol: "Ds", elementNumber: "110", elementType: "button"),
        LayoutItemModel(symbol: "Rg", elementNumber: "111", elementType: "button"),
        LayoutItemModel(symbol: "Cn", elementNumber: "112", elementType: "button"),
        LayoutItemModel(symbol: "Nh", elementNumber: "113", elementType: "button"),
        LayoutItemModel(symbol: "Fl", elementNumber: "114", elementType: "button"),
        LayoutItemModel(symbol: "Mc", elementNumber: "115", elementType: "button"),
        LayoutItemModel(symbol: "Lv", elementNumber: "116", elementType: "button"),
        LayoutItemModel(symbol: "Ts", elementNumber: "117", elementType: "button"),
        LayoutItemModel(symbol: "Og", elementNumber: "118", elementType: "button"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "lanthanideSeries", elementNumber: "", elementType: "seriesLabel"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "Ce", elementNumber: "58", elementType: "button"),
        LayoutItemModel(symbol: "Pr", elementNumber: "59", elementType: "button"),
        LayoutItemModel(symbol: "Nd", elementNumber: "60", elementType: "button"),
        LayoutItemModel(symbol: "Pm", elementNumber: "61", elementType: "button"),
        LayoutItemModel(symbol: "Sm", elementNumber: "62", elementType: "button"),
        LayoutItemModel(symbol: "Eu", elementNumber: "63", elementType: "button"),
        LayoutItemModel(symbol: "Gd", elementNumber: "64", elementType: "button"),
        LayoutItemModel(symbol: "Tb", elementNumber: "65", elementType: "button"),
        LayoutItemModel(symbol: "Dy", elementNumber: "66", elementType: "button"),
        LayoutItemModel(symbol: "Ho", elementNumber: "67", elementType: "button"),
        LayoutItemModel(symbol: "Er", elementNumber: "68", elementType: "button"),
        LayoutItemModel(symbol: "Tm", elementNumber: "69", elementType: "button"),
        LayoutItemModel(symbol: "Yb", elementNumber: "70", elementType: "button"),
        LayoutItemModel(symbol: "Lu", elementNumber: "71", elementType: "button"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "actinideSeries", elementNumber: "", elementType: "seriesLabel"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "Th", elementNumber: "90", elementType: "button"),
        LayoutItemModel(symbol: "Pa", elementNumber: "91", elementType: "button"),
        LayoutItemModel(symbol: "U", elementNumber: "92", elementType: "button"),
        LayoutItemModel(symbol: "Np", elementNumber: "93", elementType: "button"),
        LayoutItemModel(symbol: "Pu", elementNumber: "94", elementType: "button"),
        LayoutItemModel(symbol: "Am", elementNumber: "95", elementType: "button"),
        LayoutItemModel(symbol: "Cm", elementNumber: "96", elementType: "button"),
        LayoutItemModel(symbol: "Bk", elementNumber: "97", elementType: "button"),
        LayoutItemModel(symbol: "Cf", elementNumber: "98", elementType: "button"),
        LayoutItemModel(symbol: "Es", elementNumber: "99", elementType: "button"),
        LayoutItemModel(symbol: "Fm", elementNumber: "100", elementType: "button"),
        LayoutItemModel(symbol: "Md", elementNumber: "101", elementType: "button"),
        LayoutItemModel(symbol: "No", elementNumber: "102", elementType: "button"),
        LayoutItemModel(symbol: "Lr", elementNumber: "103", elementType: "button"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        LayoutItemModel(symbol: "", elementNumber: "", elementType: "period")
    ]
    
}
