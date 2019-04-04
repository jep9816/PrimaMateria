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
    @IBOutlet var tableView: UITableView?

    var nuclidesAndIsotopesArray: BehaviorRelay<[XTRIsotopeModel]>?
    
    var disposeBag: DisposeBag = DisposeBag()

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
        nuclidesAndIsotopesArray = element.nuclidesAndIsotopesModels
        
        setupRx()
    }
    
    func setupRx() {
        nuclidesAndIsotopesArray?.bind(to: (tableView?.rx.items(cellIdentifier: XTR_TABLE_CELL_IDENTIFIER, cellType: XTRTableCell.self))!) { [weak self] (row, element, cell) in
            let modulus = row % 2

            self?.delegate?.createTableCellLabel(model: XTRTableViewCellViewModel(xPos: 0, yPos: 0, width: 63, height: 32, property: element.nuclideSymbol, columnPosition: 1, modulus: modulus, cell: cell))
            self?.delegate?.createTableCellLabel(model: XTRTableViewCellViewModel(xPos: 64, yPos: 0, width: 41, height: 32, property: element.zpValue, columnPosition: 2, modulus: modulus, cell: cell))
            self?.delegate?.createTableCellLabel(model: XTRTableViewCellViewModel(xPos: 106, yPos: 0, width: 41, height: 32, property: element.nnValue, columnPosition: 3, modulus: modulus, cell: cell))
            self?.delegate?.createTableCellLabel(model: XTRTableViewCellViewModel(xPos: 148, yPos: 0, width: 124, height: 32, property: element.isotopicMass, columnPosition: 4, modulus: modulus, cell: cell))
            self?.delegate?.createTableCellLabel(model: XTRTableViewCellViewModel(xPos: 273, yPos: 0, width: 131, height: 32, property: element.halfLife, columnPosition: 5, modulus: modulus, cell: cell))
            self?.delegate?.createTableCellLabel(model: XTRTableViewCellViewModel(xPos: 405, yPos: 0, width: 118, height: 32, property: element.decayModes, columnPosition: 6, modulus: modulus, cell: cell))
            self?.delegate?.createTableCellLabel(model: XTRTableViewCellViewModel(xPos: 524, yPos: 0, width: 122, height: 32, property: element.decayEnergy, columnPosition: 7, modulus: modulus, cell: cell))
            self?.delegate?.createTableCellLabel(model: XTRTableViewCellViewModel(xPos: 647, yPos: 0, width: 78, height: 32, property: element.daughterIsotopes, columnPosition: 8, modulus: modulus, cell: cell))
            self?.delegate?.createTableCellLabel(model: XTRTableViewCellViewModel(xPos: 726, yPos: 0, width: 60, height: 32, property: element.nuclearSpin, columnPosition: 9, modulus: modulus, cell: cell))
            self?.delegate?.createTableCellLabel(model: XTRTableViewCellViewModel(xPos: 787, yPos: 0, width: 118, height: 32, property: element.isotopicComposition, columnPosition: 10, modulus: modulus, cell: cell))
            self?.delegate?.createTableCellLabel(model: XTRTableViewCellViewModel(xPos: 906, yPos: 0, width: 118, height: 32, property: element.naturalRangeVariation, columnPosition: 11, modulus: modulus, cell: cell))
            }
            .disposed(by: disposeBag)
    }

    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView!.alwaysBounceVertical = false
        tableView!.alwaysBounceHorizontal = false
        tableView!.separatorStyle = .none
        tableView!.allowsSelection = false
        tableView!.backgroundColor = UIColor.black
        tableView!.isOpaque = false
        tableView!.rowHeight = 34.0
        tableView?.register(XTRTableCell.self, forCellReuseIdentifier: XTR_TABLE_CELL_IDENTIFIER)
        
        delegate?.controller = self
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
        tableView = nil
    }
    
}
