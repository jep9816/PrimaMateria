//
//  View+Extensions.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/30/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import SwiftUI

extension View {
    
    public func formSheet<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.background(FormSheet(show: isPresented, content: content))
    }
    
    func compatibleFullScreen<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.modifier(FullScreenModifier(isPresented: isPresented, builder: content))
    }

}
