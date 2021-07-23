//
//  XTRElementBalloonView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/17/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import UIKit
import SwiftUI

struct XTRElementInspectorRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = XTRElementInspectorViewController
    
    var controllers: [UIViewController] = []
    
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
    
    func updateUIViewController(_ uiViewController: XTRElementInspectorViewController, context: Context) { }
    
}

struct XTRElementBalloonView: View {
    @EnvironmentObject var environment: ElementBallonEnvironment
    @State private var isPresented = false
    
    var body: some View {
        ZStack {
            Color(XTRColorFactory.backgroundColor)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Text(environment.element.name!)
                    .frame(width: XTRPeriodicTableViewControllerConfig.preferredContentSize.width, height: 48, alignment: .center)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.black)
                    .background(Color.init(environment.element.seriesColor))
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        XTRLabelTitleView(labelText: NSLocalizedString(ELEMENT_ATOMIC_NUMBER, comment: "Atomic Number"), width: 168.0, height: 30)
                        XTRLabelValueView(labelText: "\(environment.element.atomicNumber)", width: 168.0, height: 30)
                    }
                    
                    HStack(spacing: 0) {
                        XTRLabelTitleView(labelText: NSLocalizedString(ELEMENT_ATOMIC_MASS, comment: "Atomic Mass"), width: 168.0, height: 30)
                        XTRLabelValueView(labelText: "\(environment.element.atomicMass)", width: 168.0, height: 30)
                    }
                    
                    HStack(spacing: 0) {
                        XTRLabelTitleView(labelText: NSLocalizedString(ELEMENT_BOILING_POINT, comment: "Boiling Point"), width: 168.0, height: 30)
                        XTRLabelValueView(labelText: "\(environment.element.boilingPoint)", width: 168.0, height: 30)
                    }
                    
                    HStack(spacing: 0) {
                        XTRLabelTitleView(labelText: NSLocalizedString(ELEMENT_MELTING_POINT, comment: "Melting Point"), width: 168.0, height: 30)
                        XTRLabelValueView(labelText: "\(environment.element.meltingPoint)", width: 168.0, height: 30)
                    }
                }
                .frame(width: XTRPeriodicTableViewControllerConfig.preferredContentSize.width, height: 120, alignment: .center)
                
                XTRBaseButton(action: {
                    self.isPresented.toggle()
                }, labelText: NSLocalizedString("elementDetails", comment: "Element Details"), width: XTRPeriodicTableViewControllerConfig.preferredContentSize.width - 10, height: 32, backgroundColor: Color(XTRColorFactory.labelColor))
                .compatibleFullScreen(isPresented: $isPresented) {
                    XTRElementInspectorRepresentable(element: environment.element)
                        .frame(width: 1024, height: 768)
                }
            }
        }
    }
    
}

struct XTRElementBalloonView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        XTRElementBalloonView().environmentObject(ElementBallonEnvironment(element: XTRElementModel.testElement()))
            .previewLayout(.fixed(width: XTRPeriodicTableViewControllerConfig.preferredContentSize.width, height: XTRPeriodicTableViewControllerConfig.preferredContentSize.height))
    }
    
}
