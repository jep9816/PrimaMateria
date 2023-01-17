//
//  XTRElementListViewController.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright ©2023 xTrensa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct XTRElementListViewControllerConfig {
     static let rowHeight: CGFloat = 44.0
}

let ATOMIC_NUMBER_BUTTON_WIDTH: CGFloat = (88 * UIScreen.main.bounds.width) / 1024
let SYMBOL_BUTTON_WIDTH: CGFloat = (94 * UIScreen.main.bounds.width) / 1024
let NAME_BUTTON_WIDTH: CGFloat = (121 * UIScreen.main.bounds.width) / 1024
let ATOMIC_MASS_BUTTON_WIDTH: CGFloat = (107 * UIScreen.main.bounds.width) / 1024
let BOILING_POINT_BUTTON_WIDTH: CGFloat = (107 * UIScreen.main.bounds.width) / 1024
let MELTING_POINT_BUTTON_WIDTH: CGFloat = (107 * UIScreen.main.bounds.width) / 1024
let DENSITY_BUTTON_WIDTH: CGFloat = (107 * UIScreen.main.bounds.width) / 1024
let SERIES_BUTTON_WIDTH: CGFloat = (144 * UIScreen.main.bounds.width) / 1024
let PERIOD_BUTTON_WIDTH: CGFloat = (77 * UIScreen.main.bounds.width) / 1024
let GROUP_BUTTON_WIDTH: CGFloat = (70 * UIScreen.main.bounds.width) / 1024

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
    @IBOutlet var headerView: UIView!
    @IBOutlet var navigationBar: UINavigationBar!

    var disposeBag: DisposeBag = DisposeBag()

    private var delegate: XTRElementListViewControllerDelegate? = XTRElementListViewControllerDelegate()

    // MARK: - Initialization Methods

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
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

            //headerView.autoresizingMask = [.flexibleWidth]
            //headerView.translatesAutoresizingMaskIntoConstraints = true
            //headerView.frame.size.width = UIScreen.main.bounds.size.width
            localTableView.frame.size.width = UIScreen.main.bounds.size.width
            
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
        
        atomicNumberButton.frame = CGRect(x: 0, y: 0, width: ATOMIC_NUMBER_BUTTON_WIDTH, height: 45)
        symbolButton.frame = CGRect(x: atomicNumberButton.frame.size.width, y: 0, width: SYMBOL_BUTTON_WIDTH, height: 45)
        nameButton.frame = CGRect(x: symbolButton.frame.origin.x + symbolButton.frame.size.width, y: 0, width: NAME_BUTTON_WIDTH, height: 45)
        atomicMassButton.frame = CGRect(x: nameButton.frame.origin.x + nameButton.frame.size.width, y: 0, width: ATOMIC_MASS_BUTTON_WIDTH, height: 45)
        boilingPointButton.frame = CGRect(x: atomicMassButton.frame.origin.x + atomicMassButton.frame.size.width, y: 0, width: BOILING_POINT_BUTTON_WIDTH, height: 45)
        meltingPointButton.frame = CGRect(x: boilingPointButton.frame.origin.x + boilingPointButton.frame.size.width, y: 0, width: MELTING_POINT_BUTTON_WIDTH, height: 45)
        densityButton.frame = CGRect(x: meltingPointButton.frame.origin.x + meltingPointButton.frame.size.width, y: 0, width: DENSITY_BUTTON_WIDTH, height: 45)
        seriesButton.frame = CGRect(x: densityButton.frame.origin.x + densityButton.frame.size.width, y: 0, width: SERIES_BUTTON_WIDTH, height: 45)
        periodButton.frame = CGRect(x: seriesButton.frame.origin.x + seriesButton.frame.size.width, y: 0, width: PERIOD_BUTTON_WIDTH, height: 45)
        groupButton.frame = CGRect(x: periodButton.frame.origin.x + periodButton.frame.size.width, y: 0, width: GROUP_BUTTON_WIDTH, height: 45)

        navigationController?.navigationBar.prefersLargeTitles = true

        delegate?.closure = { [weak self] (index: Int) -> Void in
            let element = XTRDataSource.sharedInstance.element(index: index)
            self?.showElementPanel(element: element, controller: self!)
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
        delegate = nil
   }

}
