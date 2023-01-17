//
//  View+Extensions.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/30/21.
//  Copyright ©2023 Jerry Porter. All rights reserved.
//

import SwiftUI

extension View {
    
    public func formSheet<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.background(SUIFormSheet(show: isPresented, content: content))
    }
    
    func compatibleFullScreen<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.modifier(SUIFullScreenModifier(isPresented: isPresented, builder: content))
    }

}
