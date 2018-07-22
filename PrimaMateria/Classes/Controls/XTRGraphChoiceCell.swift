//
//  XTRGraphChoiceCell.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/1/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class XTRGraphChoiceCell: UICollectionViewCell {
    
    @IBOutlet var button: XTRGeneralButton!
    
    var disposeBag = DisposeBag()

//    @IBAction func chooseGraph(_ sender: UIButton) {
//        NotificationCenter.default.post(name: .graphSelectedNotification, object: sender.tag)
//    }
    
    func setup(index: Int) {
        let model = XTRDataSource.sharedInstance.graphPropertyList[index]
        let titleKey = model.title
        let title = NSLocalizedString(titleKey, comment: "")
        
        //button.addTarget(self, action: #selector(chooseGraph(_:)), for: .touchUpInside)
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
