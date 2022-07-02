//
//  Input+Output+Login.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 26.06.2022.
//

import Foundation

protocol MovieListInput: AnyObject {
    func numberOfRowsInSection(filterStatus: Bool, section: Int) -> Int
    func titleForHeaderInSection(filterStatus: Bool, section: Int) -> String
    func bookmarkButtonAction(section: Int, index: Int)
}

protocol MovieListOutput: AnyObject {
    func refresh()
}
