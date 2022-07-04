//
//  Bookmarks+Input+Output.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 2.07.2022.
//

import Foundation

protocol BookmarksInput: AnyObject {
    func viewWillAppear()
}

protocol BookmarksOutput: AnyObject {
    func refresh()
}
