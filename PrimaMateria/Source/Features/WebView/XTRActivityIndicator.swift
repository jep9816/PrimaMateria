//
//  ActivityIndicator.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/18/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import SwiftUI

struct XTRActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<XTRActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<XTRActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
