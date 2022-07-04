//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 26.06.2022.
//

import UIKit

class MovieDetailViewController: UIViewController {

    private let movieImage = UIImageView()
    private let starImage = UIImageView(image: UIImage(named: Constants.UIConstants.starImage))
    
    private let titleLabel: UILabel = .init(font: UIFont.boldSystemFont(ofSize: 32), lines: 3)
    private let movieRateLabel: UILabel = .init()
    private let overviewTitleLabel: UILabel = .init(text: Constants.UIConstants.overviewTitle,
                                                    font: UIFont.boldSystemFont(ofSize: 20),
                                                    textColor: .lightGray)
    private let overviewLabel: UILabel = .init(font: .systemFont(ofSize:16), lines: 11)
    
    private let genreStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()

    private let rateStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    
    private var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
        navigationItem.title = "Detail"
        navigationItem.largeTitleDisplayMode = .never
        
        configure()
        makeAllConstraints()
    }

    func configure() {
        view.addSubview(movieImage)
        view.addSubview(titleLabel)
        view.addSubview(genreStackView)
        view.addSubview(rateStackView)
        view.addSubview(overviewTitleLabel)
        view.addSubview(overviewLabel)
        
        movieImage.contentMode = .scaleAspectFit
        
        titleLabel.textAlignment = .center
        overviewLabel.textAlignment = .justified
    }
    
    func makeAllConstraints() {
        movieImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(248)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(movieImage.snp.bottom).offset(24)
            $0.leading.equalTo(view.snp.leading).offset(12)
            $0.trailing.equalTo(view.snp.trailing).offset(-12)
        }
        
        genreStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(24)
        }
        
        starImage.snp.makeConstraints {
            $0.size.equalTo(18)
        }
        
        rateStackView.snp.makeConstraints {
            $0.top.equalTo(genreStackView.snp.bottom).offset(16)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        overviewTitleLabel.snp.makeConstraints {
            $0.top.equalTo(rateStackView.snp.bottom).offset(28)
            $0.leading.equalTo(view.snp.leading).offset(32)
        }
        
        overviewLabel.snp.makeConstraints {
            $0.top.equalTo(overviewTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(view.snp.leading).offset(36)
            $0.trailing.equalTo(view.snp.trailing).offset(-36)
        }
    }
    
    func setMovie(movie: Movie?) {
        guard let movie = movie else { return }
        
        titleLabel.text = movie.title
        movieRateLabel.text = "\(movie.rate)/10"
        overviewLabel.text = movie.overview
        
        rateStackView.addMultipleSubviews(views: [starImage, movieRateLabel])
        genreStackView.addMultipleSubviews(views: GenreLabel.arrayOfLabels(for: movie.getGenreNames(),
                                                                              upTo: 4))
        
        movieImage.kf.indicatorType = .activity
        movieImage.kf.setImage(with: URL(string: Constants.APIConstants.baseOriginalImageURL
                                         + movie.backdropImage))
    }
    
}
