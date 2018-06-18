//
//  XTRElementListViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright ©2018 xTrensa. All rights reserved.
//

class XTRElementListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let tableViewCellIdentifier = "XTRElementTableViewCell"
    
    @IBOutlet var atomicNumberButton : XTRTableHeaderButton!
    @IBOutlet var swapView: UIView!
    
    private var tableView : UITableView?
    private var _indexPath : IndexPath?
    
    // MARK: - Initialization Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Internal Methods
    
    private func showElementPanelForElementAtIndex(_ anIndex: Int)  {
        XTRPropertiesStore.viewTitle = title!
        XTRPropertiesStore.atomicNumber = anIndex
        performSegue(withIdentifier: SegueName.showInspectorFromElementList, sender: self)
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: swapView.frame, style: .plain)
        guard let localTableView = tableView else { return }
        localTableView.alwaysBounceVertical = false
        localTableView.alwaysBounceHorizontal = false
        localTableView.delegate = self
        localTableView.dataSource = self
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
        
        _ = atomicNumberButton.toggleState()
        swapView.removeFromSuperview()
        setupTableView()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if _indexPath != nil  {
            tableView!.deselectRow(at: _indexPath!, animated: true)
        }
        super.viewDidDisappear(animated)
    }
    
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .landscape
    }
    
    // MARK: - Memory Management Methods
    
    deinit {
        atomicNumberButton = nil
        swapView = nil
    }
    
}

extension XTRElementListViewController { // TableView DataSource - Delegate
    // MARK: - UITableView DataSource Methods
    
    func tableView(_ aTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : XTRElementTableViewCell? = aTableView.dequeueReusableCell(withIdentifier: XTRElementListViewController.tableViewCellIdentifier) as? XTRElementTableViewCell
        cell!.setup(XTRDataSource.sharedInstance().sortedElementAtIndex(indexPath.row))
        
        return cell!
    }
    
    func numberOfSections(in aTableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ aTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return XTRDataSource.sharedInstance().sortedElementList!.count
    }
    
    // MARK: - UITableView Delegate Methods
    
    func tableView(_ aTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let element = XTRDataSource.sharedInstance().sortedElementAtIndex(indexPath.row)
        let atomicNumber = element.atomicNumber
        
        _indexPath = indexPath
        aTableView.deselectRow(at: indexPath, animated: true)
        showElementPanelForElementAtIndex(atomicNumber - 1)
    }
    
    func tableView(_ aTableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}
