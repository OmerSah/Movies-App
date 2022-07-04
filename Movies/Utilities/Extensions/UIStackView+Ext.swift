//
//  UIStackView+Ext.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 4.07.2022.
//

import UIKit

extension UIStackView {
    func addMultipleSubviews(views: [UIView]) {
        arrangedSubviews.forEach { (view) in
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
