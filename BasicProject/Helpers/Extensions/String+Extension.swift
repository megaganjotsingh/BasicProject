//
//  String+Extension.swift
//  BasicProject
//
//  Created by Gaganjot Singh on 02/05/24.
//

import Foundation

extension String {
    var url: URL? {
        URL(string: self)
    }
    
    /**
     - returns:
     The localized string
     */
    internal var localized: String {
        return localizedString(lang: "en")
    }

    /**

     - parameters:
     - lang: The language key for which localization is to be fetched

     - returns:
     The localized string
     */
    private func localizedString(lang: String) -> String {
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)

        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
