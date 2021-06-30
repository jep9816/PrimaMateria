//
//  XTRElementBalloonView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/17/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import UIKit
import SwiftUI

class ElementBallonEnvironment: ObservableObject {
    @Published var element: XTRElementModel!
}

struct ElementInspectorViewController: UIViewControllerRepresentable {

    typealias UIViewControllerType = XTRElementInspectorViewController

    //Company property passed from parent view. Represents the company the user selected from main view.
     private var element: XTRElementModel

     init(element: XTRElementModel?) {
         self.element = element!
     }

    func makeUIViewController(context: Context) -> XTRElementInspectorViewController {
        let elementInspector = XTRElementInspectorViewController.loadFromNib()
        elementInspector.view.backgroundColor = .black
        
        elementInspector.element = self.element
        
        return elementInspector
    }
    
    func updateUIViewController(_ uiViewController: XTRElementInspectorViewController, context: Context) {
    }
    
    var controllers: [UIViewController] = []
    
}

struct XTRElementBalloonView: View {
    @EnvironmentObject var environment: ElementBallonEnvironment
    @State private var isPresented = false
        
    var body: some View {
        VStack(spacing: 0) {
            Text(environment.element.name!)
                .frame(width: 324, height: 48, alignment: .center)
                .font(.system(size: 36, weight: .bold))
                .background(Color.init(XTRColorFactory.tableViewCellBorderColor))
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    XTRLabelTitleView(labelText: NSLocalizedString("atomicNumber", comment: "Atomic Number"), width: 168.0, height: 30)
                    XTRLabelValueView(labelText: "\(environment.element.atomicNumber)", width: 168.0, height: 30)
                }
                HStack(spacing: 0) {
                    XTRLabelTitleView(labelText: NSLocalizedString("atomicMass", comment: "Element Details"), width: 168.0, height: 30)
                    XTRLabelValueView(labelText: "\(environment.element.atomicMass)", width: 168.0, height: 30)
                }
                HStack(spacing: 0) {
                    XTRLabelTitleView(labelText: NSLocalizedString("boilingPoint", comment: "Boiling Point"), width: 168.0, height: 30)
                    XTRLabelValueView(labelText: "\(environment.element.boilingPoint)", width: 168.0, height: 30)
                }
                HStack(spacing: 0) {
                    XTRLabelTitleView(labelText: NSLocalizedString("meltingPoint", comment: "Meltinging Point"), width: 168.0, height: 30)
                    XTRLabelValueView(labelText: "\(environment.element.meltingPoint)", width: 168.0, height: 30)
                }
            }
            .frame(width: 324, height: 120, alignment: .center)
            
            // swiftlint:disable multiple_closures_with_trailing_closure
            Button(action: {
                self.isPresented.toggle()
            }) {
                Text(NSLocalizedString("elementDetails", comment: "Element Details"))
                    .lineLimit(nil)
                    .frame(width: 314, height: 32)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .background(Color(XTRColorFactory.labelColor))
                    .shadow(color: .black, radius: 1, x: 1, y: 1)
            }
            .cornerRadius(VIEW_CORNER_RADIUS)
            .padding(5)
            .compatibleFullScreen(isPresented: $isPresented) {
                ElementInspectorViewController(element: environment.element)
                    .frame(width: 1024, height: 768)
            }
        }
    }
    
}

struct XTRElementBalloonView_Previews: PreviewProvider {
    
    static var previews: some View {
        XTRElementBalloonView().previewLayout(.fixed(width: 324, height: 210))
    }
    
}
