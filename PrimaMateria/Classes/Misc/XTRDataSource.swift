//
//  XTRDataSource.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit
//import RxSwift

let sortColumns = [ELEMENT_ATOMIC_NUMBER, ELEMENT_SYMBOL, ELEMENT_NAME, ELEMENT_ATOMIC_MASS, ELEMENT_BOILING_POINT, ELEMENT_MELTING_POINT, ELEMENT_DENSITY, ELEMENT_SERIES, ELEMENT_PERIOD, ELEMENT_GROUP]

class XTRDataSource: NSObject {
    
    private static var __once: () = { _sharedInstance = XTRDataSource() }()
    static var _sharedInstance: XTRDataSource!
    
    var elementList: [XTRElementModel]!
    var sortedElementList: NSMutableArray?
    var graphPropertyList: [XTRGraphDefinitionModel] = []
    var columnSortSelector: Selector?
    
    struct Static {
        static var dispatchOnceToken = 0
    }
    
    func data(resourceName: String, type: String, directory: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let path = bundle.path(forResource: resourceName, ofType: type, inDirectory: directory)!
        var data: Data = Data()
        
        do {
            data = try Data(contentsOf: URL(fileURLWithPath: path))
        } catch {
        }
        return data
    }
    
    class var sharedInstance: XTRDataSource {
        _ = XTRDataSource.__once
        return _sharedInstance
    }
    
    func loadElement(symbol: String) {
        let theData = data(resourceName: symbol, type: FileType.plist, directory: SUPPORTING_FILES)
        var tempDict: [String: Any]?
        
        do {
            let element = XTRElementModel()
            
            try tempDict = PropertyListSerialization.propertyList(from: theData, options: PropertyListSerialization.MutabilityOptions.mutableContainers, format: nil) as? [String: Any]
            
            element.elementDictionary = tempDict!
            elementList.append(element)
        } catch _ {
            assert(nil != tempDict, "Could not read property list of element: \(symbol).")
        }
    }
    
    func loadGraphPropertyList() {
        let theData = data(resourceName: "GraphDefinitions", type: FileType.plist, directory: SUPPORTING_FILES)
        var tempList: [[String: AnyObject]]?
        
        graphPropertyList = []
        
        do {
            tempList = try PropertyListSerialization.propertyList(from: theData, options: PropertyListSerialization.MutabilityOptions.mutableContainers, format: nil) as? [[String: AnyObject]]
            for item in tempList! {
                let model = XTRGraphDefinitionModel(dictionary: item)
                graphPropertyList.append(model)
            }
        } catch _ {
            assert(nil != tempList, "Could not read graph property list.")
        }
    }
    
    func loadElementList() {
        let theData = data(resourceName: "ElementList", type: FileType.plist, directory: SUPPORTING_FILES)
        var tempList: [String]?
        
        elementList = []
        sortedElementList = NSMutableArray()

        do {
            try tempList = PropertyListSerialization.propertyList(from: theData, options: PropertyListSerialization.MutabilityOptions.mutableContainers, format: nil) as? [String]
            
            for (index, symbol) in (tempList?.enumerated())! {
                loadElement(symbol: symbol)
                sortedElementList!.add(elementList[index])
            }
        } catch _ {
            assert(nil != tempList, "Could not read property list of elements.")
        }
    }
    
    // MARK: - Initialization Methods
    
    override init() {
        super.init()

        loadGraphPropertyList()
        loadElementList()
    }
    
    // MARK: - General Methods
    
    func sortByColumn(position: Int, andOrdering: Bool) {
        let sortObject = sortColumns[Int(position)]
        let sortObject1 = sortColumns[0]
        let discripter1 = NSSortDescriptor(key: sortObject, ascending: andOrdering)
        
        if sortObject == sortObject1 {
            let discripter2 = NSSortDescriptor(key: sortObject1, ascending: andOrdering)
            
            sortedElementList!.sort(using: [discripter2, discripter1])
        } else {
            sortedElementList!.sort(using: [discripter1])
        }
    }
    
    func resetElementList() {
        let sortObject = sortColumns[0]
        let sortDesc = NSSortDescriptor(key: sortObject, ascending: true)
        sortedElementList!.sort(using: [sortDesc])
    }
    
    // MARK: - Accessor Methods
    
    func element(symbol: String) -> XTRElementModel? {
        for element in elementList where element.symbol == symbol {
            return element
        }
        
        return nil
    }
    
    func sortedElement(index: Int) -> XTRElementModel {
        return sortedElementList!.object(at: index) as! XTRElementModel
    }
    
    func element(index: Int) -> XTRElementModel {
        return elementList[index]
    }
    
    func elementCount() -> Int {
        return sortedElementList!.count
    }
    
}
