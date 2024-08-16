//
//  MoviesListViewController.swift
//  iOSTask
//
//  Created by Mohamed Nabil on 15/08/2024.
//

import Foundation
import UIKit
import Combine

final class MoviesListViewController: UIViewController {
    
    // MARK: - Factories
    private let makeMovieDetailsViewController: (Int) -> MovieDetailsViewController
    
    // MARK: - Views
    @IBOutlet weak var moviesTV: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    let viewModel: MoviesListViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - init
    init(
        viewModel: MoviesListViewModel,
        movieDetailsFactory: @escaping (Int) -> MovieDetailsViewController
    ) {
        self.viewModel = viewModel
        self.makeMovieDetailsViewController = movieDetailsFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMoviesTableView()
        observeViewModel()
        registerNotificationsObservers()
        
        viewModel.getPopularMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupMoviesTableView() {
        moviesTV.register(
            UINib(nibName: MovieTableViewCell.identifier, bundle: .main),
            forCellReuseIdentifier: MovieTableViewCell.identifier
        )
        moviesTV.dataSource = self
        moviesTV.delegate = self
        moviesTV.showsHorizontalScrollIndicator = false
        moviesTV.showsVerticalScrollIndicator = false
    }
    
    private func observeViewModel() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self else { return }
                if isLoading {
                    activityIndicator.startAnimating()
                } else {
                    activityIndicator.stopAnimating()
                }
            }
            .store(in: &subscriptions)
        
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self else { return }
                if movies != nil {
                    moviesTV.reloadData()
                }
            }
            .store(in: &subscriptions)
        
        viewModel.navigateToDetails
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movieId in
                guard let self else { return }
                self.navigateToDetailsScreen(movieId: movieId)
            }
            .store(in: &subscriptions)
    }
    
    private func registerNotificationsObservers() {
        NotificationCenter.default.publisher(for: Notification.Name(rawValue: "openMovieDetails"), object: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] notification in
                guard let self else { return }
//                guard let movieId = notification.userInfo?["movieId"] as? Int else { return }
                self.navigateToDetailsScreen(movieId: 1022789)
            }
            .store(in: &subscriptions)
    }
    
    private func navigateToDetailsScreen(movieId: Int) {
        let movieDetailsVC = self.makeMovieDetailsViewController(movieId)
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}

