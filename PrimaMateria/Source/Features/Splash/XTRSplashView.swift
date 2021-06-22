//
//  XTRSplashView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/18/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct XTRSplashView: View {

    @State var isActive: Bool = false
    
    var dismissAction: (() -> Void)

    var body: some View {
        ZStack {
            Image("LaunchImage")
            VStack {
                VStack {
                }
                .frame(width: 200, height: 20, alignment: .trailing)
                Text(Bundle.main.appNameString!)
                    .font(Font.custom("Papyrus", size: 80))
                    .frame(width: 500, height: 100, alignment: .center)
                
                // swiftlint: disable colon
                HStack {
                    HStack(alignment: .top, spacing: .none, content: {
                        Image("icon")
                            .frame(width: 64, height: 64)
                        Text("xTrensa")
                            .font(Font.custom("Papyrus", size: 80))
                            .frame(width: 280, height: 74, alignment: .trailing)
                    })
                    
                    VStack {
                        HStack {
                            Text("Version:")
                                .font(Font.custom("Papyrus", size: 22))
                                .frame(width: 150, height: 50, alignment: .trailing)
                            Text(Bundle.main.appVersionString!)
                                .font(Font.custom("Papyrus", size: 22))
                                .frame(width: 70, height: 50, alignment: .trailing)
                        }
                        .frame(width: 200, height: 50, alignment: .trailing)
                                                
                        HStack {
                            Text("Copyright:")
                                .font(Font.custom("Papyrus", size: 22))
                                .frame(width: 150, height: 50, alignment: .trailing)
                            Text(Bundle.main.copywriteString!)
                                .font(Font.custom("Papyrus", size: 22))
                                .frame(width: 70, height: 50, alignment: .trailing)
                        }
                        .frame(width: 200, height: 50, alignment: .trailing)
                    }
                }
                .padding()
                .frame(width: 600, height: 74, alignment: .leading)
                VStack {
                }
                .frame(width: 200, height: 20, alignment: .trailing)

            }
            .background(Color(.sRGB, red: 1.0, green: 1.0, blue: 1.0, opacity: 0.75)) // any non-transparent background
            .padding()
            .shadow(color: .black, radius: 4, x: 4, y: 4)
                //.border(Color.black, width: 10)
        }.scaledToFill()
        .onAppear(perform: {
            dismissAction()
        })
     }
}

struct XTRSplashView_Previews: PreviewProvider {
    
    static var previews: some View {
        XTRSplashView(dismissAction: {}).previewLayout(.fixed(width: 1024, height: 768))
    }
    
}
