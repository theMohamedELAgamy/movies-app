//
//  MovieDetailsViewController.swift
//  iOSTask
//
//  Created by Mohamed Nabil on 15/08/2024.
//

import Foundation
import UIKit
import Combine

final class MovieDetailsViewController: UIViewController {
    
    // MARK: - Views
    @IBOutlet weak var movieIV: UIImageView!
    @IBOutlet weak var textStack: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: - Properties
    private let viewModel: MovieDetailsViewModel
    private let movieId: Int
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - init
    init(
        viewModel: MovieDetailsViewModel,
        movieId: Int
    ) {
        self.viewModel = viewModel
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
        observeViewModel()
        
        viewModel.getMovieDetails(movieId: self.movieId)
    }
    
    private func setupToolbar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Movie Details"
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func updateViews(with movie: Movie) {
        movieIV.loadImage(url: movie.posterPath ?? "")
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview
        textStack.isHidden = false
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
        
        viewModel.$movie
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movie in
                guard let self, let movie else { return }
                self.updateViews(with: movie)
            }
            .store(in: &subscriptions)
    }
    
}
