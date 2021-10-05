//
//  SUIPreferencesGlobeView.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/22/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct SUIPreferencesGlobeView: UIViewRepresentable {

    let animatedImage = UIImage.animatedImage(with: (1...72).map { String(format: "Globe%02d", $0) }.map { UIImage(imageLiteralResourceName: $0) }, duration: 2.5)

    func makeUIView(context: Self.Context) -> UIView {
        let someView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 4))
        let someImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        someImageView.clipsToBounds = true
        someImageView.autoresizesSubviews = true
        someImageView.contentMode = .scaleAspectFill
        someImageView.image = animatedImage
        someView.addSubview(someImageView)
        return someView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<SUIPreferencesGlobeView>) { }
}
