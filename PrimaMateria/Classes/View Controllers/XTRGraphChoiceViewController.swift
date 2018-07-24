//
//  XTRGraphChoiceViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

class XTRGraphChoiceViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!

    private var delegate: XTRGraphChoiceViewControllerDelegate = XTRGraphChoiceViewControllerDelegate()

    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    // MARK: - Action Methods
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        view.backgroundColor = XTRColorFactory.popupArrowColor
        
        preferredContentSize = CGSize(width: 450, height: 768)
        
        collectionView.delegate = delegate
        collectionView.dataSource = delegate
        collectionView.backgroundColor = UIColor.clear
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
}
