//
//  View+Extension.swift
//  BasicProject
//
//  Created by Gaganjot Singh on 02/05/24.
//

import Foundation
import UIKit.UIView

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
