//
//  Double+Extension.swift
//  Caculate
//
//  Created by admin on 17/08/2023.
//

import Foundation

extension Double {
    var currencyFormatted: String {
        var isWholeNumber : Bool {
            isZero ? true : !isNormal ? false : self == rounded()
        }
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = isWholeNumber ? 0: 2
        return formatter.string(from: self as NSNumber) ?? ""
    }
}

