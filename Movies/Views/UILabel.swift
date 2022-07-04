//
//  UILabel+Ext.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 4.07.2022.
//

import UIKit

extension UILabel {
    convenience init(frame: CGRect = .init(), text: String? = nil, font: UIFont? = nil,
                     textColor: UIColor? = nil, lines: Int? = nil){
        self.init(frame: frame)
        if let text = text {
            self.text = text
        }
        if let font = font {
            self.font = font
        }
        if let textColor = textColor {
            self.textColor = textColor
        }
        if let lines = lines {
            self.numberOfLines = lines
            if lines != 0 {
                self.lineBreakMode = .byTruncatingTail
            }
        }
    }
    
}
