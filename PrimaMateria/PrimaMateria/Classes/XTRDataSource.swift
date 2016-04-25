//
//  XTRDataSource.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/15/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

@objc class XTRDataSource : NSObject {
    private static let _sharedInstance = XTRDataSource()
    
    var sortColumns : NSArray?
    var elementList : NSMutableArray?
    var sortedElementList : NSMutableArray?
    var graphPropertyList : NSMutableArray?
    var columnSortSelector : Selector?
    
    func dataForResource(aResourceName: String, type: String, directory: String) -> NSData {
        let bundle : NSBundle = NSBundle.init(forClass: self.classForCoder)
        let path : String = bundle.pathForResource(aResourceName, ofType: type, inDirectory: directory)!
        
        return NSData.init(contentsOfFile: path)!
    }
    
    class func sharedInstance() -> XTRDataSource {
        return _sharedInstance
    }
    
    func loadElementForSymbol(aSymbol: String)  {
        let theData : NSData = self.dataForResource(aSymbol, type: "plist", directory: SUPPORTING_FILES)
        var tempDict : NSMutableDictionary? = nil
        
        do {
            let element : XTRElement = XTRElement()
            
            try tempDict = NSPropertyListSerialization.propertyListWithData(theData, options: NSPropertyListMutabilityOptions.MutableContainers, format: nil) as? NSMutableDictionary
            
            element.elementDictionary = tempDict
            self.elementList!.addObject(element)
        } catch _ {
            assert(nil != tempDict, "Could not read property list of elements.")
        }
    }
    
    func loadElementList() {
        let theData : NSData = self.dataForResource("ElementList", type: "plist", directory: SUPPORTING_FILES)
        var tempList : NSArray? = nil
        
        do {
            try tempList = NSPropertyListSerialization.propertyListWithData(theData, options: NSPropertyListMutabilityOptions.MutableContainers, format: nil) as? NSArray
            
            for index in 0...tempList!.count - 1 {
                let symbol : String? = tempList?.objectAtIndex(index) as? String
                self.loadElementForSymbol(symbol!)
                self.sortedElementList!.addObject(self.elementList!.objectAtIndex(index))
            }
        } catch _ {
            assert(nil != tempList, "Could not read property list of elements.")
        }
    }
    
    // MARK: - Initialization Methods
    
    override init() {
        super.init()
        let theData : NSData = self.dataForResource("GraphDefinitions", type: "plist", directory: SUPPORTING_FILES)
        
        self.elementList = NSMutableArray()
        self.sortedElementList = NSMutableArray()
        self.sortColumns = ["atomicNumber.intValue", "symbol", "name", "atomicMass.floatValue", "boilingPoint.floatValue", "meltingPoint.floatValue", "density.floatValue", "series", "period", "group"]
        
        do {
            try self.graphPropertyList = NSPropertyListSerialization.propertyListWithData(theData, options: NSPropertyListMutabilityOptions.MutableContainers, format: nil) as? NSMutableArray
        } catch _ {
            self.graphPropertyList = nil
        }
        
        self.loadElementList()
    }
    
    // MARK: - General Methods
    
    func sortByColumnPosition(aColumnPosition: UInt, andOrdering: Bool) {
        let sortObject : String = self.sortColumns!.objectAtIndex(Int(aColumnPosition)) as! String
        let sortObject1 : String = self.sortColumns!.objectAtIndex(0) as! String
        let discripter1 : NSSortDescriptor = NSSortDescriptor.init(key: sortObject, ascending: andOrdering)
        
        if (sortObject == sortObject1) {
            let discripter2 : NSSortDescriptor = NSSortDescriptor.init(key: sortObject1, ascending: andOrdering)
            
            self.sortedElementList!.sortUsingDescriptors([discripter2, discripter1])
        } else {
            self.sortedElementList!.sortUsingDescriptors([discripter1])
        }
    }
    
    func resetElementList() {
        let sortObject : String = self.sortColumns!.objectAtIndex(0) as! String
        let sortDesc : NSSortDescriptor = NSSortDescriptor.init(key: sortObject, ascending: true)
        self.sortedElementList!.sortUsingDescriptors([sortDesc])
    }
    
    // MARK: - Accessor Methods
    
    func elementForSymbol(symbol: String) -> XTRElement? {
        for index in 0...self.elementList!.count {
            let element : XTRElement? = self.elementList?.objectAtIndex(index) as? XTRElement
            if (element!.symbol() == symbol) {
                return element
            }
        }
        
        return nil
    }
    
    func sortedElementAtIndex(anIndex: UInt) -> XTRElement {
        return self.sortedElementList!.objectAtIndex(Int(anIndex)) as! XTRElement
    }
    
    func elementAtIndex(anIndex: UInt) -> XTRElement {
        return self.elementList?.objectAtIndex(Int(anIndex)) as! XTRElement
    }
    
    func elementCount() -> Int {
        return self.sortedElementList!.count
    }
}
