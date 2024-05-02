//
//  Button.swift
//  BasicProject
//
//  Created by Gaganjot Singh on 02/05/24.
//

import Foundation
import UIKit

class LabelFactory: UILabel {
    var alignment: NSTextAlignment

    var cText: StringConstants?
    var cNumberOfLines: Int
    var cLineBreakMode: NSLineBreakMode
    var cAlpha: CGFloat
    var cAdjustFontSize: Bool
    var cMinimumFontScale: CGFloat

    init(
        text: StringConstants? = nil,
        alignment: NSTextAlignment = .left,
        cNumberOfLines: Int = 0,
        cLineBreakMode: NSLineBreakMode = .byTruncatingTail,
        cAlpha: CGFloat = 1.0,
        cAdjustFontSize: Bool = true,
        cMinimumFontScale: CGFloat = 0.5
    ) {
        cText = text
        self.alignment = alignment
        self.cNumberOfLines = cNumberOfLines
        self.cLineBreakMode = cLineBreakMode
        self.cAlpha = cAlpha
        self.cAdjustFontSize = cAdjustFontSize
        self.cMinimumFontScale = cMinimumFontScale
        super.init(frame: .zero)

        setUp()
    }


    required init?(coder _: NSCoder) {
        return nil
    }

    func setUp() {
        text = cText?.value
        textAlignment = alignment
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = cNumberOfLines
    }
}
