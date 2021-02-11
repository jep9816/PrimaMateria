//
//  XTRClassicColorFactory.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 6/24/18.
//  Copyright ©2020 xTrensa. All rights reserved.
//

import UIKit

class XTRColorFactoryClassic: XTRColorFactory {
    // MARK: - Classic standard colors
    
    // MARK: - Grays
    
    class var white: UIColor {
        return UIColor.color(hexString: "ffffff")
    }
    
    class var cotton: UIColor {
        return UIColor.color(hexString: "f7f7f7")
    }
    
    class var smoke: UIColor {
        return UIColor.color(hexString: "f0f0f0")
    }
    
    class var timberwolf: UIColor {
        return UIColor.color(hexString: "e0e0e0")
    }
    
    class var armadillo: UIColor {
        return UIColor.color(hexString: "cecece")
    }
    
    class var peweter: UIColor {
        return UIColor.color(hexString: "ababab")
    }
    
    class var elephant: UIColor {
        return UIColor.color(hexString: "898888")
    }
    
    class var empress: UIColor {
        return UIColor.color(hexString: "737373")
    }
    
    class var graphite: UIColor {
        return UIColor.color(hexString: "4d4d4d")
    }
    
    class var inkwell: UIColor {
        return UIColor.color(hexString: "333333")
    }
    
    // MARK: - Blues
    
    class var interactiveBlue: UIColor {
        return UIColor.color(hexString: "2da4cf")
    }
    
    class var denim: UIColor {
        return UIColor.color(hexString: "006897")
    }
    
    class var jetBlue: UIColor {
        return UIColor.color(hexString: "123d63")
    }
    
    class var downriver: UIColor {
        return UIColor.color(hexString: "0d3353")
    }
    
    // MARK: - Accents
    
    class var success: UIColor {
        return UIColor.color(hexString: "99cc00")
    }
    
    class var favorite: UIColor {
        return UIColor.color(hexString: "ffc91a")
    }
    
    class var caution: UIColor {
        return UIColor.color(hexString: "ff8800")
    }
    
    class var alert: UIColor {
        return UIColor.color(hexString: "cc0000")
    }
    
    override class var buttonBorderColor: UIColor {
        return UIColor.color(hexString: "0000ff")
    }
    
    override class var border: UIColor {
        return UIColor.color(hexString: "000000")
    }

    class var dodgerBlueColor: UIColor {
        return UIColor.color(hexString: "4093ff")
    }
    
    class var dustyGrayColor: UIColor {
        return UIColor.color(hexString: "999999")
    }
    
    class var galleryColor: UIColor {
        return UIColor.color(hexString: "eeeeee")
    }
    
    class var doveGrayColor: UIColor {
        return UIColor.color(hexString: "666666")
    }
    
    class var silverColor: UIColor {
        return UIColor.color(hexString: "cccccc")
    }
    
    class var grayColor: UIColor {
        return UIColor.color(hexString: "808080")
    }

    override class var switchBackgroundColor: UIColor {
        return XTRColorFactoryClassic.jetBlue
    }

}
