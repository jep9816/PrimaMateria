//
//  SUIPeriodicTableView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 9/8/21.
//  Copyright ©2023 Jerry Porter. All rights reserved.
//

import SwiftUI

struct SUIPeriodicTableViewConfig {
    
    static let buttonWidth = (50 * UIScreen.main.bounds.width) / 1024
    static let buttonHeight = (50 * UIScreen.main.bounds.width) / 1024
    static let preferredContentHeight: CGFloat = buttonHeight * 12
    static let preferredContentWidth: CGFloat = buttonWidth * 20
    
}

struct SUIPeriodicTableView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(XTRColorFactory.backgroundColor)
                    .ignoresSafeArea()
                VStack(alignment: .leading, spacing: 0, content: {
                    HStack(alignment: .top, spacing: 0, content: {
                        SUIHelpButtonView(helpKey: "periodicTable")
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
                        .frame(width: 20, height: SUIPeriodicTableViewConfig.buttonHeight * 8, alignment: .center)
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
                            .frame(width: SUIPeriodicTableViewConfig.preferredContentWidth, height: SUIPeriodicTableViewConfig.preferredContentHeight).offset(x: 0, y: 0)
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

struct SUIPeriodicTableView_Previews: PreviewProvider {
    
    static var previews: some View {
    SUIPeriodicTableView().previewLayout(.fixed(width: 1024, height: 768)) // 9.7
        SUIPeriodicTableView().previewLayout(.fixed(width: 2732 / 2, height: 2048 / 2)) // iPad pro
    }
    
}

struct PeriodicTableLayoutItemModel {
    
    var symbol: String = ""
    var elementNumber: String = ""
    var elementType: String = ""
    
}

struct PeriodicTableLayout {
    
    static let layoutItemModels = [
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        PeriodicTableLayoutItemModel(symbol: "1", elementNumber: "IA", elementType: "group"),
        PeriodicTableLayoutItemModel(symbol: "2", elementNumber: "IIA", elementType: "group"),
        PeriodicTableLayoutItemModel(symbol: "3", elementNumber: "IIIB", elementType: "group"),
        PeriodicTableLayoutItemModel(symbol: "4", elementNumber: "IVB", elementType: "group"),
        PeriodicTableLayoutItemModel(symbol: "5", elementNumber: "VB", elementType: "group"),
        PeriodicTableLayoutItemModel(symbol: "6", elementNumber: "VIB", elementType: "group"),
        PeriodicTableLayoutItemModel(symbol: "7", elementNumber: "VIIB", elementType: "group"),
        PeriodicTableLayoutItemModel(symbol: "8", elementNumber: "╠═", elementType: "groupLeft"),
        PeriodicTableLayoutItemModel(symbol: "9", elementNumber: "VIIIA", elementType: "group"),
        PeriodicTableLayoutItemModel(symbol: "10", elementNumber: "═╣", elementType: "groupRight"),
        PeriodicTableLayoutItemModel(symbol: "11", elementNumber: "IB", elementType: "group"),
        PeriodicTableLayoutItemModel(symbol: "12", elementNumber: "IIB", elementType: "group"),
        PeriodicTableLayoutItemModel(symbol: "13", elementNumber: "IIIA", elementType: "group"),
        PeriodicTableLayoutItemModel(symbol: "14", elementNumber: "IVA", elementType: "group"),
        PeriodicTableLayoutItemModel(symbol: "15", elementNumber: "VA", elementType: "group"),
        PeriodicTableLayoutItemModel(symbol: "16", elementNumber: "VIA", elementType: "group"),
        PeriodicTableLayoutItemModel(symbol: "17", elementNumber: "VIIA", elementType: "group"),
        PeriodicTableLayoutItemModel(symbol: "18", elementNumber: "VIIIA", elementType: "group"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        PeriodicTableLayoutItemModel(symbol: "1", elementNumber: "", elementType: "period"),
        PeriodicTableLayoutItemModel(symbol: "H", elementNumber: "1", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "He", elementNumber: "2", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        PeriodicTableLayoutItemModel(symbol: "2", elementNumber: "", elementType: "period"),
        PeriodicTableLayoutItemModel(symbol: "Li", elementNumber: "3", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Be", elementNumber: "4", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "B", elementNumber: "5", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "C", elementNumber: "6", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "N", elementNumber: "7", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "O", elementNumber: "8", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "F", elementNumber: "9", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Ne", elementNumber: "10", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        PeriodicTableLayoutItemModel(symbol: "3", elementNumber: "", elementType: "period"),
        PeriodicTableLayoutItemModel(symbol: "Na", elementNumber: "11", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Mg", elementNumber: "12", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "Al", elementNumber: "13", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Si", elementNumber: "14", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "P", elementNumber: "15", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "S", elementNumber: "16", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Cl", elementNumber: "17", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Ar", elementNumber: "18", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        PeriodicTableLayoutItemModel(symbol: "4", elementNumber: "", elementType: "period"),
        PeriodicTableLayoutItemModel(symbol: "K", elementNumber: "19", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Ca", elementNumber: "20", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Sc", elementNumber: "21", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Ti", elementNumber: "22", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "V", elementNumber: "23", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Cr", elementNumber: "24", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Mn", elementNumber: "25", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Fe", elementNumber: "26", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Co", elementNumber: "26", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Ni", elementNumber: "28", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Cu", elementNumber: "28", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Zn", elementNumber: "30", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Ga", elementNumber: "31", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Ge", elementNumber: "32", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "As", elementNumber: "33", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Se", elementNumber: "34", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Br", elementNumber: "35", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Kr", elementNumber: "36", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        PeriodicTableLayoutItemModel(symbol: "5", elementNumber: "", elementType: "period"),
        PeriodicTableLayoutItemModel(symbol: "Rb", elementNumber: "37", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Sr", elementNumber: "38", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Y", elementNumber: "39", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Zr", elementNumber: "40", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Nb", elementNumber: "41", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Mo", elementNumber: "42", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Tc", elementNumber: "43", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Ru", elementNumber: "44", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Rh", elementNumber: "45", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Pd", elementNumber: "46", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Ag", elementNumber: "47", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Cd", elementNumber: "48", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "In", elementNumber: "49", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Sn", elementNumber: "50", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Sb", elementNumber: "51", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Te", elementNumber: "52", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "I", elementNumber: "53", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Xe", elementNumber: "54", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        PeriodicTableLayoutItemModel(symbol: "6", elementNumber: "", elementType: "period"),
        PeriodicTableLayoutItemModel(symbol: "Cs", elementNumber: "55", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Ba", elementNumber: "56", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "La", elementNumber: "57", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Hf", elementNumber: "72", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Ta", elementNumber: "73", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "W", elementNumber: "74", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Re", elementNumber: "75", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Os", elementNumber: "76", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Ir", elementNumber: "77", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Pt", elementNumber: "78", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Au", elementNumber: "79", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Hg", elementNumber: "80", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Ti", elementNumber: "81", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Pb", elementNumber: "82", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Bi", elementNumber: "83", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Po", elementNumber: "84", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "At", elementNumber: "85", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Rn", elementNumber: "86", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        PeriodicTableLayoutItemModel(symbol: "7", elementNumber: "", elementType: "period"),
        PeriodicTableLayoutItemModel(symbol: "Fr", elementNumber: "87", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Ra", elementNumber: "88", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Ac", elementNumber: "89", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Rf", elementNumber: "104", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Db", elementNumber: "105", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Sg", elementNumber: "106", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Bh", elementNumber: "107", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Hs", elementNumber: "108", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Mt", elementNumber: "109", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Ds", elementNumber: "110", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Rg", elementNumber: "111", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Cn", elementNumber: "112", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Nh", elementNumber: "113", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Fl", elementNumber: "114", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Mc", elementNumber: "115", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Lv", elementNumber: "116", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Ts", elementNumber: "117", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Og", elementNumber: "118", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "lanthanideSeries", elementNumber: "", elementType: "seriesLabel"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "Ce", elementNumber: "58", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Pr", elementNumber: "59", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Nd", elementNumber: "60", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Pm", elementNumber: "61", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Sm", elementNumber: "62", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Eu", elementNumber: "63", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Gd", elementNumber: "64", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Tb", elementNumber: "65", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Dy", elementNumber: "66", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Ho", elementNumber: "67", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Er", elementNumber: "68", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Tm", elementNumber: "69", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Yb", elementNumber: "70", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Lu", elementNumber: "71", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "period"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "actinideSeries", elementNumber: "", elementType: "seriesLabel"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "Th", elementNumber: "90", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Pa", elementNumber: "91", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "U", elementNumber: "92", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Np", elementNumber: "93", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Pu", elementNumber: "94", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Am", elementNumber: "95", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Cm", elementNumber: "96", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Bk", elementNumber: "97", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Cf", elementNumber: "98", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Es", elementNumber: "99", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Fm", elementNumber: "100", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Md", elementNumber: "101", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "No", elementNumber: "102", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "Lr", elementNumber: "103", elementType: "button"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "placeholder"),
        PeriodicTableLayoutItemModel(symbol: "", elementNumber: "", elementType: "period")
    ]
    
}
