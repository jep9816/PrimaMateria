//
//  XTRElementListViewControllerDelegate.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/21/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

class XTRElementListViewControllerDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var indexPath: IndexPath?
    var closure: (Int) -> Void? = { index in return }
    
    weak var controller: XTRElementListViewController?

    func tableView(_ aTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: XTRElementTableViewCell? = aTableView.dequeueReusableCell(withIdentifier: XTRElementListViewController.tableViewCellIdentifier) as? XTRElementTableViewCell
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
        
        self.indexPath = indexPath
        aTableView.deselectRow(at: indexPath, animated: true)
        self.closure(atomicNumber - 1)
    }
    
    func tableView(_ aTableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}
