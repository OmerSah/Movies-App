//
//  MovieListCell.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 24.06.2022.
//

import UIKit

class MovieListCell: UITableViewCell {

    private let movieTitleLabel = UILabel()
    private let movieRateLabel = UILabel()
    private let movieDescriptionLabel = UILabel()
    private let movieImage = UIImageView(image: UIImage(systemName: "questionmark.circle"))
    private let starImage = UIImageView(image: UIImage(named: "Star"))
    
    private var movie: Movie?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        makeAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMovie(movie: Movie) {
        self.movie = movie
        
        movieTitleLabel.text = movie.title
        movieRateLabel.text = "\(movie.rate)/10"
        movieDescriptionLabel.text = movie.overview
    }
    
    private func configure() {
        
        addSubview(movieTitleLabel)
        addSubview(movieRateLabel)
        addSubview(movieImage)
        addSubview(movieDescriptionLabel)
        addSubview(starImage)
        
        movieTitleLabel.lineBreakMode = .byTruncatingTail
        movieTitleLabel.numberOfLines = 3
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        movieImage.image = UIImage(named: "Movie")
        movieImage.layer.cornerRadius = 15
        movieImage.clipsToBounds = true
        
        movieDescriptionLabel.text = """
        The world's most lethal odd couple - bodyguard Michael Bryce and hitman Darius Kincaid - are back on another dasldasda
        """
        movieDescriptionLabel.lineBreakMode = .byTruncatingTail
        movieDescriptionLabel.numberOfLines = 5
        movieDescriptionLabel.textColor = .lightGray
        movieDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    
    
    private func makeAllConstraints() {
        movieImage.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(8)
            $0.leading.equalTo(8)
            $0.width.equalTo(182)
            $0.bottom.equalTo(snp.bottom).offset(-8)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(8)
            $0.leading.equalTo(movieImage.snp.trailing).offset(12)
            $0.trailing.equalTo(-16)
        }
        
        starImage.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(movieImage.snp.trailing).offset(16)
            $0.size.equalTo(18)
        }
        
        movieRateLabel.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(starImage.snp.trailing).offset(4)
            $0.trailing.equalTo(-16)
        }
        
        movieDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(movieRateLabel.snp.bottom).offset(16)
            $0.leading.equalTo(movieImage.snp.trailing).offset(16)
            $0.trailing.equalTo(-16)
        }
    }
}
