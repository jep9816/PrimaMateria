//
//  XTRGraphChoiceCell.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 7/1/18.
//  Copyright ©2023 xTrensa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class XTRGraphChoiceCell: UICollectionViewCell {

    var button: UIButton! //XTRGeneralButton!

    var disposeBag: DisposeBag = DisposeBag()

    func setup(index: Int) {
        let model = XTRDataSource.sharedInstance.graphPropertyList[index]
        let titleKey = model.title
        let title = NSLocalizedString(titleKey, comment: "")
        
        button = UIButton(type: .custom)
        
        button.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: XTRGraphViewControllerConfig.buttonSize)
        button.setTitle(title, for: UIControl.State())
        button.tag = index
        setProperties()
 
        for state in [UIControl.State.normal, UIControl.State.highlighted, UIControl.State.selected, UIControl.State.disabled] {
            if let title = button.title(for: state) {
                button.setTitle(NSLocalizedString(title, comment: ""), for: state)
            }
        }
 
        contentView.addSubview(button)

        Observable.of(
            mapToObserver(button: button)
            ).merge().subscribe(onNext: { sender in
                NotificationCenter.default.post(name: .graphSelectedNotification, object: sender.tag)
            }).disposed(by: disposeBag)
    }

    func setProperties() {
        button.titleLabel?.contentMode = .center
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.cornerRadius = VIEW_CORNER_RADIUS
        button.masksToBounds = true
        button.borderWidth = 1.0
        button.borderColor = UIColor.darkGray
        button.titleLabel!.textAlignment = NSTextAlignment.center
        button.backgroundColor = XTRColorFactoryClassic.silverColor
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = XTRFontFactory.systemFont16
    }

}
