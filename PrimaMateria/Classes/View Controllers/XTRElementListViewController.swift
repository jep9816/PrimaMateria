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
    
    // MARK: - Action Methods
    
    @IBAction func sortTableView(_ sender: XTRTableHeaderButton) {
        
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
        navigationController?.navigationBar.prefersLargeTitles = true
        
        delegate?.closure = { [weak self] (index: Int) -> Void in
            self?.showElementPanelForElementAtIndex(index: index)
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
        navigationBar =  nil
    }
    
}
