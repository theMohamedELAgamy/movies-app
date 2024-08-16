//
//  AppDependancyContainer.swift
//  iOSTask
//
//  Created by Mohamed Nabil on 16/08/2024.
//

import Foundation

final class AppDependancyContainer {
    
    static let shared = AppDependancyContainer()
    
    private init() { }
    
    func makeSplashViewController() -> SplashViewController {
        let moviesListFactory = { () -> MoviesListViewController in
            let viewModel = self.makeMoviesListViewModel()
            return self.makeMoviesListViewController(viewModel: viewModel)
        }
        
        return SplashViewController(makeMoviesListFactory: moviesListFactory)
    }
    
    private func makeMoviesListViewModel() -> MoviesListViewModel {
        MoviesListViewModel(
            repository: MovieRepository(
                remote: MovieRemoteDataSource(
                    webClient: BaseWebClient()
                )
            )
        )
    }
    
    private func makeMoviesListViewController(viewModel: MoviesListViewModel) -> MoviesListViewController {
        let movieDetailsFactory = { (movieId: Int) -> MovieDetailsViewController in
            let viewModel = self.makeMovieDetailsViewModel()
            
            return self.makeMovieDetailsViewController(viewModel: viewModel, movieId: movieId)
        }
        
        return MoviesListViewController(viewModel: viewModel, movieDetailsFactory: movieDetailsFactory)
    }
    
    private func makeMovieDetailsViewModel() -> MovieDetailsViewModel {
        MovieDetailsViewModel(
            repository: MovieRepository(
                remote: MovieRemoteDataSource(
                    webClient: BaseWebClient()
                )
            )
        )
    }
    
    private func makeMovieDetailsViewController(
        viewModel: MovieDetailsViewModel,
        movieId: Int
    ) -> MovieDetailsViewController {
        MovieDetailsViewController(viewModel: viewModel, movieId: movieId)
    }
    
    
}
