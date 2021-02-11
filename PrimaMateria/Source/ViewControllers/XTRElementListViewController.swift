//
//  XTRElementListViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright ©2021 xTrensa. All rights reserved.
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
    @IBOutlet var tableView: UITableView!
    @IBOutlet var navigationBar: UINavigationBar!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    private var delegate: XTRElementListViewControllerDelegate? = XTRElementListViewControllerDelegate()
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    private func setupTableView() {
        if let localTableView = tableView {
            localTableView.alwaysBounceVertical = false
            localTableView.alwaysBounceHorizontal = false
            localTableView.delegate = delegate
            localTableView.dataSource = delegate
            localTableView.separatorStyle = .none
            localTableView.backgroundColor = UIColor.black
            localTableView.allowsSelection = true
            localTableView.allowsMultipleSelection = false
            localTableView.register(XTRElementTableViewCell.classForCoder(), forCellReuseIdentifier: XTRElementListViewController.tableViewCellIdentifier)
            
            view.addSubview(tableView!)
        }
    }
    
    private func mapToObserverHeaderButton(button: XTRTableHeaderButton) -> Observable<XTRTableHeaderButton> {
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
        XTRDataSource.sharedInstance.sortByColumn(position: sender.tag, ascending: sender.toggleState())
        tableView!.reloadData()
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("elementList", comment: "")
        navigationBar.topItem?.title = title
        
        _ = atomicNumberButton.toggleState()
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
        navigationBar =  nil
        tableView = nil
        //tableView.delegate = nil
    }
    
}
