//
//  UIResponse+Extension.swift
//  Caculate
//
//  Created by admin on 22/06/2023.
//

import Foundation
import UIKit

extension UIResponder {
        var parentViewController: UIViewController? {
            return next as? UIViewController ?? next?.parentViewController
        }
}
