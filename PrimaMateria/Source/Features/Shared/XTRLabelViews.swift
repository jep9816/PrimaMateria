//
//  XTRLabelViews.swift
//  PrimaMateria PRD
//
//  Created by Jerry Porter on 6/30/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct XTRLabelTitleView: View {
    
    var labelText: String!
    var width: CGFloat = 10
    var height: CGFloat = 10

    var body: some View {
        Text("  " + labelText + ": ")
            .frame(width: self.width, height: self.height, alignment: .leading)
            .font(.system(size: 18, weight: .bold))
            .background(Color.white)
            .border(Color.black, width: 1)
    }
    
}

struct XTRFormTitleView: View {
    
    var labelText: String!
    var width: CGFloat = 10
    var height: CGFloat = 10

    var body: some View {
        Text("  " + labelText + ": ")
            .frame(width: self.width, height: self.height, alignment: .trailing)
            .font(.system(size: 18, weight: .bold))
            .background(Color.clear)
    }
    
}

struct XTRLabelValueView: View {
    
    var labelText: String!
    var width: CGFloat = 10
    var height: CGFloat = 10

    var body: some View {
        Text(" " + labelText)
            .frame(width: width, height: self.height, alignment: .leading)
            .font(.system(size: 18, weight: .regular))
            .background(Color.white)
            .border(Color.black, width: 1)
    }
    
}
