//
//  XTRDataSource.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit

let sortColumns = [ELEMENT_ATOMIC_NUMBER, ELEMENT_SYMBOL, ELEMENT_NAME, ELEMENT_ATOMIC_MASS, ELEMENT_BOILING_POINT, ELEMENT_MELTING_POINT, ELEMENT_DENSITY, ELEMENT_SERIES, ELEMENT_PERIOD, ELEMENT_GROUP]

class XTRDataSource : NSObject {
    
    private static var __once: () = { _sharedInstance = XTRDataSource() }()
    static var _sharedInstance : XTRDataSource!
    
    var elementList : [XTRElement]!
    var sortedElementList : NSMutableArray?
    var graphPropertyList : [[String : AnyObject]]?
    var columnSortSelector : Selector?
    
    struct Static {
        static var dispatchOnceToken = 0
    }
    
    func dataForResource(_ aResourceName: String, type: String, directory: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let path = bundle.path(forResource: aResourceName, ofType: type, inDirectory: directory)!
        
        return try! Data(contentsOf: URL(fileURLWithPath: path))
    }
    
    class func sharedInstance() -> XTRDataSource {
        _ = XTRDataSource.__once
        return _sharedInstance
    }
    
    func loadElementForSymbol(_ aSymbol: String)  {
        let theData = dataForResource(aSymbol, type: FileType.plist, directory: SUPPORTING_FILES)
        var tempDict : [String : Any]?
        
        do {
            let element = XTRElement()
            
            try tempDict = PropertyListSerialization.propertyList(from: theData, options: PropertyListSerialization.MutabilityOptions.mutableContainers, format: nil) as? [String : Any]
            
            element.elementDictionary = tempDict!
            elementList.append(element)
        } catch _ {
            assert(nil != tempDict, "Could not read property list of elements.")
        }
    }
    
    func loadElementList() {
        let theData = dataForResource("ElementList", type: FileType.plist, directory: SUPPORTING_FILES)
        var tempList : NSArray? = nil
        
        do {
            try tempList = PropertyListSerialization.propertyList(from: theData, options: PropertyListSerialization.MutabilityOptions.mutableContainers, format: nil) as? NSArray
            
            for index in 0..<tempList!.count {
                let symbol : String? = tempList?.object(at: index) as? String
                loadElementForSymbol(symbol!)
                sortedElementList!.add(elementList[index])
            }
        } catch _ {
            assert(nil != tempList, "Could not read property list of elements.")
        }
    }
    
    // MARK: - Initialization Methods
    
    override init() {
        super.init()
        let theData = dataForResource("GraphDefinitions", type: FileType.plist, directory: SUPPORTING_FILES)
        
        elementList = []
        sortedElementList = NSMutableArray()
        do {
            try graphPropertyList = PropertyListSerialization.propertyList(from: theData, options: PropertyListSerialization.MutabilityOptions.mutableContainers, format: nil) as? [[String : AnyObject]]
        } catch _ {
            graphPropertyList = nil
        }
        
        loadElementList()
    }
    
    // MARK: - General Methods
    
    func sortByColumnPosition(_ aColumnPosition: Int, andOrdering: Bool) {
        let sortObject = sortColumns[Int(aColumnPosition)]
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
    
    func elementForSymbol(_ symbol: String) -> XTRElement? {
        for index in 0..<elementList.count {
            let element = elementList[index]
            
            if element.symbol == symbol {
                return element
            }
        }
        
        return nil
    }
    
    func sortedElementAtIndex(_ anIndex: Int) -> XTRElement {
        return sortedElementList!.object(at: anIndex) as! XTRElement
    }
    
    func elementAtIndex(_ anIndex: Int) -> XTRElement {
        return elementList[anIndex]
    }
    
    func elementCount() -> Int {
        return sortedElementList!.count
    }
    
}
