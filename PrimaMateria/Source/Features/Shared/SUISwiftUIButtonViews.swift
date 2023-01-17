//
//  SUISwiftUIButtonViewss.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/22/21.
//  Copyright ©2023 Jerry Porter. All rights reserved.
//

import SwiftUI

struct SUIBaseButton: View {
    
    var action: () -> Void
    var labelText: String!
    var width: CGFloat = 10
    var height: CGFloat = 10
    var backgroundColor: Color
    
    var body: some View {
        Button(action: action) {
            Text(labelText)
                .frame(width: width, height: height, alignment: .center)
                .foregroundColor(.white)
                .background(backgroundColor)
                .shadow(color: .black, radius: 1, x: 1, y: 1)
        }
        .cornerRadius(VIEW_CORNER_RADIUS)
        .padding(5)
    }
    
}
