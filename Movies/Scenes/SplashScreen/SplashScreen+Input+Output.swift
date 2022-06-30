//
//  SplashScreen+Input+Output.swift
//  Movies
//
//  Created by Ömer Faruk Şahin on 30.06.2022.
//

import Foundation

protocol SplashScreenInput: AnyObject {
    func viewDidLoad()
}

protocol SplashScreenOutput: AnyObject {
    func createTabBar()
    func showError(error: MovieError)
}
