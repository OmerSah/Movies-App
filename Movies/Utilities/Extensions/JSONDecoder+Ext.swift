//
//  JSONDecoder+Ext.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 28.06.2022.
//

import Foundation

extension JSONDecoder {
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.movieDateFormatter)
        return jsonDecoder
    }()
}
