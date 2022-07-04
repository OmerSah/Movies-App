//
//  GenreLabel.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 4.07.2022.
//

import UIKit

class GenreLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    init(genre: String){
        super.init(frame: .zero)
        text = "   " + genre + "   "
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        backgroundColor = .init(red: 219.0/255.0, green: 227.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        layer.masksToBounds = true
        layer.cornerRadius = 10
        font = UIFont.boldSystemFont(ofSize: 12)
        textColor = .init(red: 136.0/255.0, green: 164.0/255.0, blue: 232.0/255.0, alpha: 1.0)
    }
}

extension GenreLabel {
    static func arrayOfLabels(for titles: [String], upTo: Int) -> [GenreLabel] {
        var count = 0
        var labels = [GenreLabel]()
        for title in titles {
            if count >= upTo {
                return labels
            }
            labels += [GenreLabel(genre: title)]
            count += 1
        }
        return labels
    }
}
