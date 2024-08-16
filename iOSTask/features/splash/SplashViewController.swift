//
//  SplashViewController.swift
//  iOSTask
//
//  Created by Mohamed Nabil on 16/08/2024.
//

import Foundation
import UIKit


final class SplashViewController: UIViewController {
    
    // MARK: - Factories
    private let makeMoviesListViewController: () -> MoviesListViewController
    
    // MARK: - init
    init(makeMoviesListFactory: @escaping () -> MoviesListViewController) {
        self.makeMoviesListViewController = makeMoviesListFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.navigateToMoviesList()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    private func navigateToMoviesList() {
        let moviesListVC = makeMoviesListViewController()
        self.navigationController?.viewControllers = [moviesListVC]
    }
    
}
