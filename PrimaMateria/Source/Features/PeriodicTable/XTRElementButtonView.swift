//
//  XTRElementButtonView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 9/9/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct XTRElementButtonView: View {

    var action: () -> Void
    var symbolText: String!
    var elementNumber: Int!
    var width: CGFloat!
    var height: CGFloat!

    var body: some View {
        Button(action: action) {
            Text(symbolText)
                .frame(minWidth: width, maxWidth: .infinity, minHeight: height, maxHeight: .infinity, alignment: .center)
                .font(XTRFontFactory.boldSystem32)
                .background(backgroundColor(elementNumber))
                .foregroundColor(forgroundColor(elementNumber))
        }
        .cornerRadius(VIEW_CORNER_RADIUS)
     }
    
    func backgroundColor(_ elementNumber: Int) -> Color {
        return Color(XTRDataSource.sharedInstance.element(index: elementNumber - 1).seriesColor)
    }
    
    func forgroundColor(_ elementNumber: Int) -> Color {
        return Color(XTRDataSource.sharedInstance.element(index: elementNumber - 1).standardConditionColor)
    }
    
//    func setupColors() {
//        let backgroundColor = XTRDataSource.sharedInstance.element(index: tag).seriesColor
//        let selectedImage = UIImage.imageFromColor(backgroundColor.inverseColor(), andSize: frame.size)
//
//        setBackgroundImage(UIImage.imageFromColor(backgroundColor, andSize: frame.size), for: UIControl.State())
//        setBackgroundImage(selectedImage, for: .highlighted)
//        setBackgroundImage(selectedImage, for: .selected)
//    }

}

struct XTRElementButtonView_Previews: PreviewProvider {
    
    static var previews: some View {
        XTRElementButtonView(action: {}, symbolText: "He", elementNumber: 1)
    }
    
}
