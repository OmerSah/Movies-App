//
//  MovieListCell.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 24.06.2022.
//

import UIKit
import Kingfisher

class MovieListCell: UITableViewCell {

    private let movieTitleLabel: UILabel = .init(font: UIFont.boldSystemFont(ofSize: 24), lines: 4)
    private let movieRateLabel: UILabel = .init()
    private let movieDescriptionLabel: UILabel = .init(font: UIFont.systemFont(ofSize: 16), textColor: .lightGray, lines: 4)
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    private let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    private let starImage = UIImageView(image: UIImage(named: Constants.UIConstants.starImage))
    
    private let bookmarkButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(systemName: Constants.UIConstants.bookmarkImage), for: .normal)
        button.setImage(UIImage(systemName: Constants.UIConstants.selectedBookmarkImage), for: .selected)
        button.addTarget(self, action: #selector(bookmarkButtonAction), for: .touchUpInside)
        return button
    }()
    
    private var movie: Movie?
    var bookmarkAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        makeAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(movieTitleLabel)
        addSubview(movieRateLabel)
        addSubview(movieImage)
        contentView.addSubview(bookmarkButton)
        addSubview(movieDescriptionLabel)
        addSubview(starImage)
        addSubview(stackView)
    }
    
    private func makeAllConstraints() {
        movieImage.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(8)
            $0.leading.equalTo(8)
            $0.width.equalTo(182)
            $0.bottom.equalTo(snp.bottom).offset(-8)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.top.equalTo(movieImage.snp.top).offset(8)
            $0.trailing.equalTo(movieImage.snp.trailing).offset(-8)
        }
        
        bookmarkButton.imageView?.snp.makeConstraints {
            $0.size.equalTo(32)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(8)
            $0.leading.equalTo(movieImage.snp.trailing).offset(12)
            $0.trailing.equalTo(-16)
        }
        
        starImage.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(movieImage.snp.trailing).offset(16)
            $0.size.equalTo(18)
        }
        
        movieRateLabel.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(starImage.snp.trailing).offset(4)
            $0.trailing.equalTo(-16)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(movieRateLabel.snp.bottom).offset(12)
            $0.leading.equalTo(movieImage.snp.trailing).offset(16)
            $0.height.equalTo(24)
        }
        
        movieDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(12)
            $0.leading.equalTo(movieImage.snp.trailing).offset(16)
            $0.trailing.equalTo(-16)
        }
    }
    
    func setMovie(movie: Movie?) {
        guard let movie = movie else { return }
        self.movie = movie
        
        movieTitleLabel.text = movie.title
        movieRateLabel.text = "\(movie.rate)/10"
        movieDescriptionLabel.text = movie.overview
        
        bookmarkButton.isSelected = movie.isFav
        movieImage.kf.setImage(with: URL(string: Constants.APIConstants.baseImageURL + movie.posterImage))
        
        stackView.addMultipleSubviews(views: GenreLabel.arrayOfLabels(for: movie.getGenreNames(), upTo: 2))
    }
    
    @objc private func bookmarkButtonAction() {
        bookmarkAction?()
    }
}
