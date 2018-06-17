//
//  PrimaMateriaTests.swift
//  PrimaMateriaTests
//
//  Created by Jerry Porter on 6/17/18.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import UIKit
import XCTest

class PrimaMateriaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // should return white color if named color not found
        var color = UIColor.searchForColor(byName: "foo")
        XCTAssert(UIColor.white == color)
        
        color = UIColor.searchForColor(byName: "lawngreen")
        XCTAssert(UIColor.white != color)

        print("\(color.red())")
    }
    
}
