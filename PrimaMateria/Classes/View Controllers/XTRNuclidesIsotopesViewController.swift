//
//  XTRNuclidesIsotopesViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/20/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class XTRNuclidesIsotopesViewController: XTRSwapableViewController {
    
    @IBOutlet var headerView: UIView!
    @IBOutlet var swapView: UIView!
    
    var nuclidesAndIsotopesArray: BehaviorRelay<[XTRIsotopeModel]>?
    
    private var tableView: UITableView?
    private var delegate: XTRNuclidesIsotopesViewControllerDelegate? = XTRNuclidesIsotopesViewControllerDelegate()

    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
        
    // MARK: - Misc Methods
    
    override func setupUIForAnimation(element: XTRElementModel) {
        super.setupUIForAnimation(element: element)
        
        setupTableView(element: element)
    }
    
    override func setupUI(element: XTRElementModel) {
        super.setupUI(element: element)
        
        setupTableView(element: element)
    }
    
    func setupTableView(element: XTRElementModel) {
        if tableView != nil {
            tableView!.removeFromSuperview()
            tableView = nil
        }
        
        nuclidesAndIsotopesArray = element.nuclidesAndIsotopesModels
        tableView = UITableView(frame: swapView.frame, style: .plain)
        
        tableView!.alwaysBounceVertical = false
        tableView!.alwaysBounceHorizontal = false
        tableView!.dataSource = delegate
        tableView!.delegate = delegate
        tableView!.separatorStyle = .none
        tableView!.allowsSelection = false
        tableView!.backgroundColor = UIColor.black
        tableView!.backgroundView = UIView(frame: swapView.frame)
        tableView!.backgroundView!.backgroundColor = UIColor.black
        tableView!.isOpaque = false
        view.addSubview(tableView!)
        
        tableView!.reloadData()
    }
    
    // MARK: - Action Methods
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate?.controller = self
        swapView.removeFromSuperview()
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        headerView = nil
        swapView = nil
    }
    
}
