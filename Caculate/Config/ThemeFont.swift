//
//  ThemeFont.swift
//  Caculate
//
//  Created by admin on 16/06/2023.
//

import Foundation
import UIKit

struct ThemeFont {
    
    static func regular(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "AvenirNext-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func bold(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "AvenirNext-Bold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func demibold(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "AvenirNext-DemiBold", size: size) ?? .systemFont(ofSize: size)
    }
}
