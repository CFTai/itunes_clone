//
//  customLabel.swift
//  itunesClone
//
//  Created by Stephen Tai on 6/4/2021.
//

import UIKit

class customLabel: UILabel {

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: 5.0, dy: 5.0))
    }
}
