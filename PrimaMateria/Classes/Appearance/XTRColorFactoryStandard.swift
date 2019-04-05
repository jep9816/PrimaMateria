//
//  XTRColorFactoryStandard.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 12/5/16.
//  Copyright © 2019 xTrensa. All rights reserved.
//

import UIKit

class XTRColorFactoryStandard: XTRColorFactory {
    // MARK: - iOS standard colors
    
    // Grays
    
    class var whiteSmoke: UIColor {
        return UIColor.color(hexString: "F8F8F8")
    }
    
    class var lightGray: UIColor {
        return UIColor.lightGray
    }
    
    class var suvaGrey: UIColor {
        return UIColor.color(hexString: "929292")
    }
    
    class var lavender: UIColor {
        return UIColor.color(hexString: "efeff4")
    }
    
    class var comet: UIColor {
        return UIColor.color(hexString: "6d6d72")
    }
    
    class var greySuit: UIColor {
        return UIColor.color(hexString: "8e8e93")
    }
    
    class var nobel: UIColor {
        return UIColor.color(hexString: "979797")
    }
    
    class var ghost: UIColor {
        return UIColor.color(hexString: "c7c7cc")
    }
    
    class var separator: UIColor {
        return UIColor.color(hexString: "c7c7cc")
    }
    
    class var group: UIColor {
        return UIColor.color(hexString: "ebebf1")
    }
    
    // Blues
    
    class var navyBlue: UIColor {
        return UIColor.color(hexString: "0a60fe")
    }
    
    class var regalBlue: UIColor {
        return UIColor.color(hexString: "123d63")
    }
    
    // MARK: - Accents
    
    class var wavesOfGrass: UIColor {
        return UIColor.color(hexString: "44db5e")
    }
    
    class var mediumGoldenrod: UIColor {
        return UIColor.color(hexString: "e8e8ab")
    }
    
    class var redOrange: UIColor {
        return UIColor.color(hexString: "fc3d39")
    }
    
    class var redHero: UIColor {
        return UIColor.color(hexString: "fe3824")
    }
    
    override class var buttonBorderColor: UIColor {
        return UIColor.color(hexString: "000000")
    }

    override class var border: UIColor {
        return UIColor.lightGray
    }
    
    // Other Colors
    
    class var caution: UIColor {
        return UIColor.color(hexString: "ff8800")
    }
    
    class var lightText: UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
    }
    
    class var textured: UIColor {
        return UIColor.color(hexString: "5c5566")
    }
    
    class var flipSide: UIColor {
        return UIColor.color(hexString: "18191b")
    }
    
    class var darkText: UIColor {
        return UIColor.color(hexString: "000000")
    }
    
    override class var switchBackgroundColor: UIColor {
        return XTRColorFactoryStandard.navyBlue
    }

    class var standardRedColor: UIColor {
        return UIColor(red: 222 / 255, green: 0 / 255, blue: 21 / 255, alpha: 1.0)
    }

    class var seamlessMetalTextureColor: UIColor {
        return UIColor(patternImage: UIImage(named: "seamless-metal-texture")!)
    }

}
