//
//  XTRElementListViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class XTRElementListViewController: UIViewController {
    
    static let tableViewCellIdentifier = "XTRElementTableViewCell"
    
    @IBOutlet var atomicNumberButton: XTRTableHeaderButton!
    @IBOutlet var symbolButton: XTRTableHeaderButton!
    @IBOutlet var nameButton: XTRTableHeaderButton!
    @IBOutlet var atomicMassButton: XTRTableHeaderButton!
    @IBOutlet var boilingPointButton: XTRTableHeaderButton!
    @IBOutlet var meltingPointButton: XTRTableHeaderButton!
    @IBOutlet var densityButton: XTRTableHeaderButton!
    @IBOutlet var seriesButton: XTRTableHeaderButton!
    @IBOutlet var periodButton: XTRTableHeaderButton!
    @IBOutlet var groupButton: XTRTableHeaderButton!
    @IBOutlet var swapView: UIView!
    @IBOutlet var navigationBar: UINavigationBar!
    
    var disposeBag = DisposeBag()

    private var tableView: UITableView?
    private var delegate: XTRElementListViewControllerDelegate? = XTRElementListViewControllerDelegate()
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
        
    private func setupTableView() {
        tableView = UITableView(frame: swapView.frame, style: .plain)
        tableView!.alwaysBounceVertical = false
        tableView!.alwaysBounceHorizontal = false
        tableView!.delegate = delegate
        tableView!.dataSource = delegate
        tableView!.separatorStyle = .none
        tableView!.backgroundColor = UIColor.black
        tableView!.allowsSelection = true
        tableView!.allowsMultipleSelection = false
        tableView!.register(XTRElementTableViewCell.classForCoder(), forCellReuseIdentifier: XTRElementListViewController.tableViewCellIdentifier)
        view.addSubview(tableView!)
    }
    
    internal func mapToObserverHeaderButton(button: XTRTableHeaderButton) -> Observable<XTRTableHeaderButton> {
        return button.rx.tap.map { _ in return button}
    }

    func setupRx() {
        let array = [
            mapToObserverHeaderButton(button: atomicNumberButton),
            mapToObserverHeaderButton(button: symbolButton),
            mapToObserverHeaderButton(button: nameButton),
            mapToObserverHeaderButton(button: atomicMassButton),
            mapToObserverHeaderButton(button: boilingPointButton),
            mapToObserverHeaderButton(button: meltingPointButton),
            mapToObserverHeaderButton(button: densityButton),
            mapToObserverHeaderButton(button: seriesButton),
            mapToObserverHeaderButton(button: periodButton),
            mapToObserverHeaderButton(button: groupButton)
        ]
        Observable.merge(array).subscribe(onNext: { [weak self] sender in
            self?.sortTableView(sender)
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Action Methods
    
    func sortTableView(_ sender: XTRTableHeaderButton) {
        if tableView != nil {
            tableView!.delegate = nil
            tableView!.dataSource = nil
            tableView!.removeFromSuperview()
            tableView = nil
        }
        
        XTRDataSource.sharedInstance.sortByColumn(position: sender.tag, andOrdering: sender.toggleState())
        setupTableView()
        tableView!.reloadData()
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("elementList", comment: "")
        navigationBar.topItem?.title = title

        _ = atomicNumberButton.toggleState()
        swapView.removeFromSuperview()
        setupTableView()
        setupRx()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        delegate?.closure = { [weak self] (index: Int) -> Void in
            self?.showElementPanelForElement(index: index, controller: self!)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if delegate?.indexPath != nil {
            tableView!.deselectRow(at: (delegate?.indexPath!)!, animated: XTRPropertiesStore.showTransitionsState)
        }
        super.viewDidDisappear(animated)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        atomicNumberButton = nil
        symbolButton = nil
        nameButton = nil
        atomicMassButton = nil
        boilingPointButton = nil
        meltingPointButton = nil
        densityButton = nil
        seriesButton = nil
        periodButton = nil
        groupButton = nil
        swapView = nil
        navigationBar =  nil
    }
    
}
