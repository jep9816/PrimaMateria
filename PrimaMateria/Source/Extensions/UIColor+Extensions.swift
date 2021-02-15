//
//  UIColor+Extensions.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 10/24/16.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import UIKit

let colorNameDB = "," +
    "aliceblue#f0f8ff,antiquewhite#faebd7,aqua#00ffff,aquamarine#7fffd4,azure#f0ffff," +
    "beige#f5f5dc,bisque#ffe4c4,black#000000,blanchedalmond#ffebcd,blue#0000ff," +
    "blueviolet#8a2be2,brown#a52a2a,burlywood#deb887,cadetblue#5f9ea0,chartreuse#7fff00," +
    "chocolate#d2691e,coral#ff7f50,cornflowerblue#6495ed,cornsilk#fff8dc,crimson#dc143c," +
    "cyan#00ffff,darkblue#00008b,darkcyan#008b8b,darkgoldenrod#b8860b,darkgray#a9a9a9," +
    "darkgreen#006400,darkgrey#a9a9a9,darkkhaki#bdb76b,darkmagenta#8b008b," +
    "darkolivegreen#556b2f,darkorange#ff8c00,darkorchid#9932cc,darkred#8b0000," +
    "darksalmon#e9967a,darkseagreen#8fbc8f,darkslateblue#483d8b,darkslategray#2f4f4f," +
    "darkslategrey#2f4f4f,darkturquoise#00ced1,darkviolet#9400d3,deeppink#ff1493," +
    "deepskyblue#00bfff,dimgray#696969,dimgrey#696969,dodgerblue#1e90ff," +
    "firebrick#b22222,floralwhite#fffaf0,forestgreen#228b22,fuchsia#ff00ff," +
    "gainsboro#dcdcdc,ghostwhite#f8f8ff,gold#ffd700,goldenrod#daa520,gray#808080," +
    "green#008000,greenyellow#adff2f,grey#808080,honeydew#f0fff0,hotpink#ff69b4," +
    "indianred#cd5c5c,indigo#4b0082,ivory#fffff0,khaki#f0e68c,lavender#e6e6fa," +
    "lavenderblush#fff0f5,lawngreen#7cfc00,lemonchiffon#fffacd,lightblue#add8e6," +
    "lightcoral#f08080,lightcyan#e0ffff,lightgoldenrodyellow#fafad2,lightgray#d3d3d3," +
    "lightgreen#90ee90,lightgrey#d3d3d3,lightpink#ffb6c1,lightsalmon#ffa07a," +
    "lightseagreen#20b2aa,lightskyblue#87cefa,lightslategray#778899," +
    "lightslategrey#778899,lightsteelblue#b0c4de,lightyellow#ffffe0,lime#00ff00," +
    "limegreen#32cd32,linen#faf0e6,magenta#ff00ff,maroon#800000,mediumaquamarine#66cdaa," +
    "mediumblue#0000cd,mediumorchid#ba55d3,mediumpurple#9370db,mediumseagreen#3cb371," +
    "mediumslateblue#7b68ee,mediumspringgreen#00fa9a,mediumturquoise#48d1cc," +
    "mediumvioletred#c71585,midnightblue#191970,mintcream#f5fffa,mistyrose#ffe4e1," +
    "moccasin#ffe4b5,navajowhite#ffdead,navy#000080,oldlace#fdf5e6,olive#808000," +
    "olivedrab#6b8e23,orange#ffa500,orangered#ff4500,orchid#da70d6,palegoldenrod#eee8aa," +
    "palegreen#98fb98,paleturquoise#afeeee,palevioletred#db7093,papayawhip#ffefd5," +
    "peachpuff#ffdab9,peru#cd853f,pink#ffc0cb,plum#dda0dd,powderblue#b0e0e6," +
    "purple#800080,red#ff0000,rosybrown#bc8f8f,royalblue#4169e1,saddlebrown#8b4513," +
    "salmon#fa8072,sandybrown#f4a460,seagreen#2e8b57,seashell#fff5ee,sienna#a0522d," +
    "silver#c0c0c0,skyblue#87ceeb,slateblue#6a5acd,slategray#708090,slategrey#708090," +
    "snow#fffafa,springgreen#00ff7f,steelblue#4682b4,tan#d2b48c,teal#008080," +
    "thistle#d8bfd8,tomato#ff6347,turquoise#40e0d0,violet#ee82ee,wheat#f5deb3," +
"white#ffffff,whitesmoke#f5f5f5,yellow#ffff00,yellowgreen#9acd32,copper#B87333,brass#B5A642"

extension UIColor { // Expanded

    var colorSpaceModel: CGColorSpaceModel {
        return cgColor.colorSpace!.model
    }

    func canProvideRGBComponents() -> Bool {
        switch colorSpaceModel {
        case CGColorSpaceModel.rgb, .monochrome:
            return true
        default:
            return false
        }
    }

    func red() -> CGFloat {
        assert(canProvideRGBComponents(), "Must be an RGB color to use -red")
        let components = cgColor.components!
        return components[0]
    }

    func green() -> CGFloat {
        assert(canProvideRGBComponents(), "Must be an RGB color to use -green")
        let components = cgColor.components!
        if colorSpaceModel == .monochrome {
            return components[0]
        }
        return components[1]
    }

    func blue() -> CGFloat {
        assert(canProvideRGBComponents(), "Must be an RGB color to use -blue")
        let components = cgColor.components!
        if colorSpaceModel == .monochrome {
            return components[0]
        }
        return components[2]
    }

    func white() -> CGFloat {
        assert(colorSpaceModel == .monochrome, "Must be a Monochrome color to use -white")
        let components = cgColor.components!
        return components[0]
    }

    func alpha() -> CGFloat {
        return cgColor.alpha
    }

    class func color(rgbHex hex: UnsafeMutablePointer<UInt64>) -> UIColor {
        let hexValue = UnsafeMutablePointer<UInt64>(hex).pointee
        let r = (hexValue >> 16) & 0xFF
        let g = (hexValue >> 8) & 0xFF
        let b = (hexValue) & 0xFF

        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1.0))
    }

    class func color(hexString: String) -> UIColor {
        let scanner = Scanner(string: hexString)
        let hexNum: UnsafeMutablePointer<UInt64> = UnsafeMutablePointer<UInt64>.allocate(capacity: 1)

        if !scanner.scanHexInt64(hexNum) {
            return UIColor.white
        }

        return UIColor.color(rgbHex: hexNum)
    }

    class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(RAND_MAX) / CGFloat(arc4random()), green: CGFloat(RAND_MAX) / CGFloat(arc4random()), blue: CGFloat(RAND_MAX) / CGFloat(arc4random()), alpha: CGFloat(1.0))
    }

    class func searchForColor(byName cssColorName: String) -> UIColor {
        var result = UIColor.white
        let searchString = ",\(cssColorName)#"

        guard let range: Range<String.Index> = colorNameDB.range(of: searchString) else {
            return result
        }

        if !range.isEmpty {
            let indexFrom = colorNameDB.index((range.lowerBound), offsetBy: cssColorName.count + 2)
            let indexTo = colorNameDB.index((range.lowerBound), offsetBy: cssColorName.count + 8)
            let newRange  = indexFrom..<indexTo

            if !newRange.isEmpty {
                result =  UIColor.color(hexString: String(colorNameDB[indexFrom..<indexTo]))
            }
        }

        return result
    }

    func stringFromColor() -> String? {
        assert(canProvideRGBComponents(), "Must be an RGB color to use -stringFromColor")
        var result: String?

        switch colorSpaceModel {
        case .rgb:
            result = String(format: "{%0.3f, %0.3f, %0.3f, %0.3f}", arguments: [red(), green(), blue(), alpha()])
        case .monochrome:
            result = String(format: "{%0.3f, %0.3f}", arguments: [white(), alpha()])
        default:
            result = nil
        }

        return result
    }

    func colorSpaceString() -> String {
        switch self.colorSpaceModel {
        case .unknown:
            return "Unknown"
        case .monochrome:
            return "Monochrome"
        case .rgb:
            return "RGB"
        case .cmyk:
            return "CMYK"
        case .lab:
            return "Lab"
        case .deviceN:
            return "DeviceN"
        case .indexed:
            return "Indexed"
        case .pattern:
            return "Pattern"
        default:
            return STRING_EMPTY
        }
    }

    func arrayFromRGBAComponents() -> [CGFloat] {
        assert(canProvideRGBComponents(), "Must be an RGB color to use -arrayFromRGBAComponents")
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var alpha: CGFloat = 0

        if !self.red(&r, green: &g, blue: &b, alpha: &alpha) {
            return [CGFloat]()
        }
        return [r, g, b, alpha]
    }

    func red( _ red: inout CGFloat, green: inout CGFloat, blue: inout CGFloat, alpha: inout CGFloat) -> Bool {
        let components: [CGFloat] = cgColor.components!
        var r: CGFloat
        var g: CGFloat
        var b: CGFloat
        var alphaValue: CGFloat
        switch self.colorSpaceModel {
        case .monochrome:
            r = components[0]
            g = components[0]
            b = components[0]
            alphaValue = components[1]
        case CGColorSpaceModel.rgb:
            r = components[0]
            g = components[1]
            b = components[2]
            alphaValue = components[3]
        default:
            // We don't know how to handle this model
            return false
        }

        if red != 0.0 {
            red = r
        }
        if green != 0.0 {
            green = g
        }
        if blue != 0.0 {
            blue = b
        }
        if alpha != 0.0 {
            alpha = alphaValue
        }
        return true
    }

    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &alpha)
        let pt1 = (Int)(r*255)<<16
        let pt2 = (Int)(g*255)<<8
        let pt3 = (Int)(b*255)<<0

        let rgb = pt1 | pt2 | pt3

        return String(format: "#%06x", rgb)
    }

    func inverseColor() -> UIColor {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var alpha: CGFloat = 0.0

        if getRed(&r, green: &g, blue: &b, alpha: &alpha) {
            return UIColor(red: 1.0-r, green: 1.0 - g, blue: 1.0 - b, alpha: alpha)
        }
        return self
    }

}
