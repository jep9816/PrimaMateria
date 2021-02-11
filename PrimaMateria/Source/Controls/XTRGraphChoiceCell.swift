//
//  XTRGraphChoiceCell.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/1/18.
//  Copyright ©2020 xTrensa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class XTRGraphChoiceCell: UICollectionViewCell {
    
    @IBOutlet var button: XTRGeneralButton!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    func setup(index: Int) {
        let model = XTRDataSource.sharedInstance.graphPropertyList[index]
        let titleKey = model.title
        let title = NSLocalizedString(titleKey, comment: "")
        
        button.setTitle(title, for: .normal)
        button.setTitle(title, for: .highlighted)
        button.showsTouchWhenHighlighted = false
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.tag = index

        Observable.of(
            mapToObserver(button: button)
            ).merge().subscribe(onNext: { sender in
                NotificationCenter.default.post(name: .graphSelectedNotification, object: sender.tag)
            }).disposed(by: disposeBag)
    }
    
}
