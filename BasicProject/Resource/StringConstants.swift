//
//  StringConstants.swift
//  BasicProject
//
//  Created by Gaganjot Singh on 02/05/24.
//

import Foundation

enum StringConstants: String {
    case ok
}

extension StringConstants {
    var value: String {
        return rawValue.localized
    }

    func localizedValue(with argument: [CVarArg]) -> String {
        return String(format: rawValue.localized, arguments: argument)
    }
}
