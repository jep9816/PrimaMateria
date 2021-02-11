//
//  XTRDataSource.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import UIKit

let sortColumns = [ELEMENT_ATOMIC_NUMBER, ELEMENT_SYMBOL, ELEMENT_NAME, ELEMENT_ATOMIC_MASS, ELEMENT_BOILING_POINT, ELEMENT_MELTING_POINT, ELEMENT_DENSITY, ELEMENT_SERIES, ELEMENT_PERIOD, ELEMENT_GROUP]

class XTRDataSource: NSObject {
    
    private static var __once: () = { _sharedInstance = XTRDataSource() }()
    static var _sharedInstance: XTRDataSource!
    
    var elementList: [XTRElementModel] = []
    var sortedElementList: [XTRElementModel] = [] //NSMutableArray = NSMutableArray()
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
                graphPropertyList.append(XTRGraphDefinitionModel(dictionary: item))
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
                sortedElementList.append(element!)
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
        switch sortColumns[position] {
        case ELEMENT_ATOMIC_NUMBER:
            sortedElementList = sortedElementList.sorted(by: { (lhsTemp: XTRElementModel, rhsTemp: XTRElementModel) -> Bool in
                return ascending ? (lhsTemp.atomicNumber < rhsTemp.atomicNumber) : (lhsTemp.atomicNumber > rhsTemp.atomicNumber)
            })
        case ELEMENT_SYMBOL:
            sortedElementList = sortedElementList.sorted(by: { (lhsTemp: XTRElementModel, rhsTemp: XTRElementModel) -> Bool in
                return ascending ? (lhsTemp.symbol! < rhsTemp.symbol!) : (lhsTemp.symbol! > rhsTemp.symbol!)
            })
        case ELEMENT_NAME:
            sortedElementList = sortedElementList.sorted(by: { (lhsTemp: XTRElementModel, rhsTemp: XTRElementModel) -> Bool in
                return ascending ? (lhsTemp.name! < rhsTemp.name!) : (lhsTemp.name! > rhsTemp.name!)
            })
        case ELEMENT_ATOMIC_MASS:
            sortedElementList = sortedElementList.sorted(by: { (lhsTemp: XTRElementModel, rhsTemp: XTRElementModel) -> Bool in
                return ascending ? (lhsTemp.atomicMass < rhsTemp.atomicMass) : (lhsTemp.atomicMass > rhsTemp.atomicMass)
            })
        case ELEMENT_BOILING_POINT:
            sortedElementList = sortedElementList.sorted(by: { (lhsTemp: XTRElementModel, rhsTemp: XTRElementModel) -> Bool in
                return ascending ? (lhsTemp.boilingPoint < rhsTemp.boilingPoint) : (lhsTemp.boilingPoint > rhsTemp.boilingPoint)
            })
        case ELEMENT_MELTING_POINT:
            sortedElementList = sortedElementList.sorted(by: { (lhsTemp: XTRElementModel, rhsTemp: XTRElementModel) -> Bool in
                return ascending ? (lhsTemp.meltingPoint < rhsTemp.meltingPoint) : (lhsTemp.meltingPoint > rhsTemp.meltingPoint)
            })
        case ELEMENT_DENSITY:
            sortedElementList = sortedElementList.sorted(by: { (lhsTemp: XTRElementModel, rhsTemp: XTRElementModel) -> Bool in
                return ascending ? (lhsTemp.density < rhsTemp.density) : (lhsTemp.density > rhsTemp.density)
            })
        case ELEMENT_SERIES:
            sortedElementList = sortedElementList.sorted(by: { (lhsTemp: XTRElementModel, rhsTemp: XTRElementModel) -> Bool in
                return ascending ? (lhsTemp.series! < rhsTemp.series!) : (lhsTemp.series! > rhsTemp.series!)
            })
        case ELEMENT_PERIOD:
            sortedElementList = sortedElementList.sorted(by: { (lhsTemp: XTRElementModel, rhsTemp: XTRElementModel) -> Bool in
                return ascending ? (lhsTemp.period! < rhsTemp.period!) : (lhsTemp.period! > rhsTemp.period!)
            })
        case ELEMENT_GROUP:
            sortedElementList = sortedElementList.sorted(by: { (lhsTemp: XTRElementModel, rhsTemp: XTRElementModel) -> Bool in
                return ascending ? (lhsTemp.group! < rhsTemp.group!) : (lhsTemp.group! > rhsTemp.group!)
            })
        default:
            return
        }
    }
    
    // MARK: - Accessor Methods
    
    func element(symbol: String) -> XTRElementModel? {
        return elementList.filter { $0.symbol == symbol }[0]
    }
    
    func sortedElement(index: Int) -> XTRElementModel {
        return sortedElementList[index]
    }
    
    func element(index: Int) -> XTRElementModel {
        return elementList[index]
    }
    
    func elementCount() -> Int {
        return sortedElementList.count
    }
    
}
