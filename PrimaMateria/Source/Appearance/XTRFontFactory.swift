//
//  XTRFontFactory.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 9/8/21.
//  Copyright © 2021 Jerry Porter. All rights reserved.
//

import Foundation
import SwiftUI

class XTRFontFactory: NSObject {
    
    // MARK: - SwiftUI Fonts
    
    class var system32: Font {
        return .system(size: 32.0)
    }

    class var system18: Font {
        return .system(size: 18.0)
    }

    class var system17: Font {
        return .system(size: 17.0)
    }

    class var boldSystem32: Font {
        return .system(size: 32, weight: .bold)
    }
    
    class var boldSystem26: Font {
        return .system(size: 26, weight: .bold)
    }

    class var boldSystem18: Font {
        return .system(size: 18, weight: .bold)
    }

    class var boldSystem17: Font {
        return .system(size: 17, weight: .bold)
    }
    
    class var regularSystem18: Font {
        return .system(size: 18, weight: .regular)
    }

    class var regularSystem14: Font {
        return .system(size: 14, weight: .regular)
    }

    class var papyrusSystem48: Font {
        return .custom("Papyrus", size: 48.0)
    }

    class var papyrusSystem36: Font {
        return .custom("Papyrus", size: 36.0)
    }

    class var papyrusSystem18: Font {
        return .custom("Papyrus", size: 18.0)
    }

    // MARK: - UIKit UIFonts
    class var boldSystemFont30: UIFont {
        return UIFont.boldSystemFont(ofSize: 30)
    }

    class var boldSystemFont26: UIFont {
        return UIFont.boldSystemFont(ofSize: 26)
    }

    class var boldSystemFont20: UIFont {
        return UIFont.boldSystemFont(ofSize: 20)
    }

    class var boldSystemFont18: UIFont {
        return UIFont.boldSystemFont(ofSize: 18)
    }
    
    class var boldSystemFont15: UIFont {
        return UIFont.boldSystemFont(ofSize: 15)
    }

    class var boldSystemFont12: UIFont {
        return UIFont.boldSystemFont(ofSize: 12)
    }
    
    class var systemFont40: UIFont {
        return UIFont.systemFont(ofSize: 40)
    }
    
    class var systemFont26: UIFont {
        return UIFont.systemFont(ofSize: 26)
    }

    class var systemFont20: UIFont {
        return UIFont.systemFont(ofSize: 20)
    }

    class var systemFont16: UIFont {
        return UIFont.systemFont(ofSize: 16)
    }

    class var systemFont14: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }

}
