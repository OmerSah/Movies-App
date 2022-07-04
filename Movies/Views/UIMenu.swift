//
//  UIMenu+Ext.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 3.07.2022.
//

import UIKit

extension UIMenu {
    convenience init(menuTitle: String ,titles: [String], handler: @escaping ((String) -> Void)) {
        var actions = [UIAction]()
        for title in titles {
            actions.append(UIAction(title: title, handler: { action in handler(action.title) }))
        }
        self.init(title: menuTitle, children: actions)
    }
}
