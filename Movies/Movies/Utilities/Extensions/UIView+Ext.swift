//
//  UIView+Ext.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 26.06.2022.
//

import SnapKit
import UIKit

extension UIView {
    func pin(to view: UIView) {
        self.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
}
