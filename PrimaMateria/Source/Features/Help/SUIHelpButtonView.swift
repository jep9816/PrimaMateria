//
//  SUIHelpButtonView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 9/30/21.
//  Copyright ©2023 Jerry Porter. All rights reserved.
//

import SwiftUI

struct SUIHelpButtonView: View {
    
    var helpKey: String

    var body: some View {
        // swiftlint:disable multiple_closures_with_trailing_closure
        Button(action: {
            print(helpKey)
        }) {
            Text("?")
                .font(XTRFontFactory.boldSystem32).italic()
                .frame(width: 32, height: 32, alignment: .center)
                .foregroundColor(Color.black)
                .background(RoundedRectangle(cornerRadius: VIEW_CORNER_RADIUS).stroke(Color.black, lineWidth: 2.0))
        }
        .background(Color(XTRColorFactory.helpBackgroundColor))
    }
}

struct SUIHelpButtonView_Previews: PreviewProvider {
    
    static var previews: some View {
        SUIHelpButtonView(helpKey: "periodicTable")
    }
    
}
