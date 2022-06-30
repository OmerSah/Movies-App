//
//  File.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 28.06.2022.
//

import Foundation

extension DateFormatter {
    static let movieDateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            return dateFormatter
    }()
}
