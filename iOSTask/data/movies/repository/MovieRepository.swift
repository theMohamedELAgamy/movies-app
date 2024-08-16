//
//  MoviesRepository.swift
//  iOSTask
//
//  Created by Mohamed Nabil on 15/08/2024.
//

import Foundation
import Alamofire
import Combine

final class MovieRepository {
    
    private let remote: MovieRemoteDataSource
    
    init(remote: MovieRemoteDataSource) {
        self.remote = remote
    }
    
    func getPopularMovies() -> Future<[Movie]?, AFError> {
        remote.getPopularMovies()
            .map { $0.results }
            .asFuture()
    }
    
    func getMovieDetails(movieId: Int) -> Future<Movie, AFError> {
        remote.getMovieDetails(movieId: movieId)
    }
    
}
