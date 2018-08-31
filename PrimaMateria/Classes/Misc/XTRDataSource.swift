//
//  XTRDataSource.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

let sortColumns = [ELEMENT_ATOMIC_NUMBER, ELEMENT_SYMBOL, ELEMENT_NAME, ELEMENT_ATOMIC_MASS, ELEMENT_BOILING_POINT, ELEMENT_MELTING_POINT, ELEMENT_DENSITY, ELEMENT_SERIES, ELEMENT_PERIOD, ELEMENT_GROUP]

class XTRDataSource: NSObject {
    
    private static var __once: () = { _sharedInstance = XTRDataSource() }()
    static var _sharedInstance: XTRDataSource!
    
    var elementList: [XTRElementModel] = []
    var sortedElementList: NSMutableArray = NSMutableArray()
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
    
    func loadElement(symbol: String) -> XTRElementModel? {
        let theData = data(resourceName: symbol, type: FileType.json, directory: SUPPORTING_FILES)
        var element: XTRElementModel?
        
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: theData, options: [.mutableContainers, .allowFragments])
            
            guard let tempDict = jsonResponse as? [String: Any] else {
                return nil
            }
            
            element = XTRElementModel(dict: tempDict)
        } catch _ {
            print("Could not read property list of element: \(symbol).")
        }
        
        return element
    }
    
    func loadGraphPropertyList() {
        let theData = data(resourceName: "GraphDefinitions", type: FileType.json, directory: SUPPORTING_FILES)
        
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: theData, options: [.mutableContainers, .allowFragments])
            
            guard let tempList = jsonResponse as? [[String: AnyObject]] else {
                return
            }

            for item in tempList {
                let model = XTRGraphDefinitionModel(dictionary: item)
                
                graphPropertyList.append(model)
            }
        } catch _ {
            print("Could not read graph property list.")
        }
    }
    
    func loadElementList() {
        let theData = data(resourceName: "ElementList", type: FileType.json, directory: SUPPORTING_FILES)
 
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: theData, options: [.mutableContainers, .allowFragments])
            
            guard let tempList = jsonResponse as? [String] else {
                return
            }
            
            for symbol in tempList {
                let element = loadElement(symbol: symbol)
                
                elementList.append(element!)
                sortedElementList.add(element! as XTRElementModel)
            }
        } catch _ {
            print("Could not read property list of elements.")
        }
    }
    
    // MARK: - Initialization Methods
    
    override init() {
        super.init()

        loadGraphPropertyList()
        loadElementList()
    }
    
    // MARK: - General Methods
    
    func sortByColumn(position: Int, ascending: Bool) {
        let sortObject = sortColumns[position]
        let sortObject1 = sortColumns[0]
        let discripter1 = NSSortDescriptor(key: sortObject, ascending: ascending)
        
        if sortObject == sortObject1 {
            let discripter2 = NSSortDescriptor(key: sortObject1, ascending: ascending)
            
            sortedElementList.sort(using: [discripter2, discripter1])
        } else {
            sortedElementList.sort(using: [discripter1])
        }
    }
    
    // MARK: - Accessor Methods
    
    func element(symbol: String) -> XTRElementModel? {
        return elementList.filter { $0.symbol == symbol }[0]
    }
    
    func sortedElement(index: Int) -> XTRElementModel {
        return sortedElementList.object(at: index) as! XTRElementModel
    }
    
    func element(index: Int) -> XTRElementModel {
        return elementList[index]
    }
    
    func elementCount() -> Int {
        return sortedElementList.count
    }
    
}
