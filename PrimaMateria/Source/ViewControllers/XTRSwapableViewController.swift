//
//  XTRSwapableViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/20/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol XTRSwapable {
    func setupUI(element: XTRElementModel)
    func setupUIForAnimation(element: XTRElementModel)
}

class XTRSwapableViewController: UIViewController, XTRSwapable {

    var disposeBag: DisposeBag = DisposeBag()
    
    var element: XTRElementModel?

    // MARK: - Initialization Methods

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    func setupUI(element: XTRElementModel) {
        self.element = element
    }

    func setupUIForAnimation(element: XTRElementModel) {
        self.element = element
    }

    // MARK: - View Management Methods

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    // MARK: - Memory Management Methods

}
