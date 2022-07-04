//
//  Input+Output+Login.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 26.06.2022.
//

import Foundation

protocol MovieListInput: AnyObject {
    func viewWillAppear()
    func numberOfRowsInSection(filterStatus: Bool, section: Int) -> Int
    func titleForHeaderInSection(filterStatus: Bool, section: Int) -> String
    func categoriesMenuHandler(title: String)
}

protocol MovieListOutput: AnyObject {
    func refresh()
}
