//
//  MoviesRemoteDataSource.swift
//  iOSTask
//
//  Created by Mohamed Nabil on 15/08/2024.
//

import Foundation
import Alamofire
import Combine

final class MovieRemoteDataSource {
    
    private let baseMovieUrl = "/movie"
    private let webClient: BaseWebClient
    
    init(webClient: BaseWebClient) {
        self.webClient = webClient
    }
    
    func getPopularMovies() -> Future<MovieResponse, AFError> {
        webClient.request(url: baseMovieUrl.appending("/popular"))
    }
    
    func getMovieDetails(movieId: Int) -> Future<Movie, AFError> {
        webClient.request(url: baseMovieUrl.appending("/\(movieId)"))
    }
    
    
}
