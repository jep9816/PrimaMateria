//
//  NEWElementBalloonViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/17/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import SwiftUI

class ElementBallonEnvironment: ObservableObject {
    @Published var titleLabel = NSLocalizedString("help", comment: "Help")
    @Published var elementTipPath = ""
}

struct XTRElementBalloon: View {

    var body: some View {
        ZStack(alignment: .topLeading) {
            GeometryReader { geometry in
                ZStack(alignment: .topLeading) {
                    // swiftlint:disable unused_closure_parameter
                    GeometryReader { geometry in
                        Text("Element Name").frame(width: 320, height: 48, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                            .font(.system(size: 36, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0))
                            .background(Color(red: 0.75, green: 0.75, blue: 0.75))
                            .offset(x: 0, y: -5)
                        
                        Text("atomicNumber").frame(width: 168, height: 30)
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0))
                            .background(Color(red: 1.0, green: 1.0, blue: 1.0))
                            .offset(x: 1, y: 44)
                        
                        Text("").frame(width: 148, height: 30)
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0))
                            .background(Color(red: 1.0, green: 1.0, blue: 1.0))
                            .offset(x: 171, y: 44)
                        
                        Text("atomicMass").frame(width: 168, height: 30)
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0))
                            .background(Color(red: 1.0, green: 1.0, blue: 1.0))
                            .offset(x: 1, y: 75)
                        
                        Text("").frame(width: 148, height: 30)
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0))
                            .background(Color(red: 1.0, green: 1.0, blue: 1.0))
                            .offset(x: 171, y: 75)
                        
                        Text("boilingPoint").frame(width: 168, height: 30)
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0))
                            .background(Color(red: 1.0, green: 1.0, blue: 1.0))
                            .offset(x: 1, y: 106)
                        
                        Text("").frame(width: 148, height: 30)
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0))
                            .background(Color(red: 1.0, green: 1.0, blue: 1.0))
                            .offset(x: 171, y: 106)
                        
                        Text("").frame(width: 148, height: 30)
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0))
                            .background(Color(red: 1.0, green: 1.0, blue: 1.0))
                            .offset(x: 171, y: 137)
                        
                        Text("meltingPoint").frame(width: 168, height: 30)
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.0))
                            .background(Color(red: 1.0, green: 1.0, blue: 1.0))
                            .offset(x: 1, y: 137)
                    }
                }
                .frame(width: 320, height: 167)
                .background(Color(red: 0.25, green: 0.25, blue: 0.25))
                .offset(x: 2, y: 2)
                
                // swiftlint:disable multiple_closures_with_trailing_closure
                Button(action: {}) {
                    Text("elementDetails").lineLimit(1).font(.system(size: 16, weight: .bold))
                        .frame(width: 320, height: 32, alignment: .center)
                }
                .aspectRatio(contentMode: .fit)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.white)
                .background(Color(red: 0.75, green: 0.75, blue: 0.75))
                .offset(x: 2, y: 176)
            }
        }
        .frame(width: 324, height: 210)
        .background(Color(red: 0.25, green: 0.25, blue: 0.25))
        .edgesIgnoringSafeArea(.all)
    }
}

struct NEWElementBalloonViewController_Previews: PreviewProvider {
    static var previews: some View {
        XTRElementBalloon()
    }
}
