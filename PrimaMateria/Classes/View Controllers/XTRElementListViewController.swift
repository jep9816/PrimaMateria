//
//  XTRElementListViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

class XTRElementListViewController: UIViewController {
    
    static let tableViewCellIdentifier = "XTRElementTableViewCell"
    
    @IBOutlet var atomicNumberButton: XTRTableHeaderButton!
    @IBOutlet var swapView: UIView!
    @IBOutlet var navigationBar: UINavigationBar!
    
    private var tableView: UITableView?
    private weak var delegate: XTRElementListViewControllerDelegate? = XTRElementListViewControllerDelegate()
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    public func showElementPanelForElementAtIndex(_ anIndex: Int) {
        XTRPropertiesStore.viewTitle = title!
        XTRPropertiesStore.atomicNumber = anIndex
        performSegue(withIdentifier: SegueName.showInspectorFromElementList, sender: self)
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: swapView.frame, style: .plain)
        guard let localTableView = tableView else { return }
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
    
    // MARK: - Action Methods
    
    @IBAction func sortTableView(_ sender: XTRTableHeaderButton) {
        let toggleState = sender.toggleState()
        
        if tableView != nil {
            tableView!.delegate = nil
            tableView!.dataSource = nil
            tableView!.removeFromSuperview()
            tableView = nil
        }
        
        XTRDataSource.sharedInstance().sortByColumnPosition(sender.tag, andOrdering: toggleState)
        setupTableView()
        tableView!.reloadData()
    }
    
    // MARK: - View Management Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("elementList", comment: "")
        navigationBar.topItem?.title = NSLocalizedString("elementList", comment: "")

        _ = atomicNumberButton.toggleState()
        swapView.removeFromSuperview()
        setupTableView()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        delegate?.closure = { [weak self] (index: Int) -> Void in
            XTRPropertiesStore.viewTitle = (self?.title)!
            XTRPropertiesStore.atomicNumber = index
            self?.performSegue(withIdentifier: SegueName.showInspectorFromElementList, sender: self)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if delegate?.indexPath != nil {
            tableView!.deselectRow(at: (delegate?.indexPath!)!, animated: true)
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
        swapView = nil
    }
    
}
