//
//  XTRFormSheet+Wrapper.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/30/21.
//  Copyright ©2021 Jerry Porter. All rights reserved.
//

import UIKit
import SwiftUI

class FormSheetWrapper<Content: View>: UIViewController, UIPopoverPresentationControllerDelegate {

    var content: () -> Content
    var onDismiss: (() -> Void)?

    private var hostVC: UIHostingController<Content>?

    required init?(coder: NSCoder) { fatalError("") }

    init(content: @escaping () -> Content) {
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }

    func show() {
        guard hostVC == nil else { return }
        let viewController = UIHostingController(rootView: content())

        viewController.view.sizeToFit()
        viewController.preferredContentSize = viewController.view.bounds.size

        viewController.modalPresentationStyle = .formSheet
        viewController.presentationController?.delegate = self
        viewController.modalTransitionStyle = .crossDissolve

        hostVC = viewController
        self.present(viewController, animated: true, completion: nil)
    }

    func hide() {
        guard let viewController = self.hostVC, !viewController.isBeingDismissed else { return }
        dismiss(animated: true, completion: nil)
        hostVC = nil
    }

    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        hostVC = nil
        self.onDismiss?()
    }
    
}

struct FormSheet<Content: View>: UIViewControllerRepresentable {

    @Binding var show: Bool

    let content: () -> Content

    func makeUIViewController(context: UIViewControllerRepresentableContext<FormSheet<Content>>) -> FormSheetWrapper<Content> {

        let viewController = FormSheetWrapper(content: content)
        viewController.onDismiss = { self.show = false }
        return viewController
    }

    func updateUIViewController(_ uiViewController: FormSheetWrapper<Content>, context: UIViewControllerRepresentableContext<FormSheet<Content>>) {
        if show {
            uiViewController.show()
        } else {
            uiViewController.hide()
        }
    }
    
}

struct FullScreenModifier<V: View>: ViewModifier {
    
    let isPresented: Binding<Bool>
    let builder: () -> V

    @ViewBuilder
    func body(content: Content) -> some View {
        if UIScreen.main.bounds.width == 1024 && UIScreen.main.bounds.height == 768 {
            content.fullScreenCover(isPresented: isPresented, content: builder)
        } else {
            content.formSheet(isPresented: isPresented, content: builder)
        }
    }
    
}
