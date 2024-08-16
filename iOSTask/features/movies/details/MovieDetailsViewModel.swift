//
//  MovieDetailsViewModel.swift
//  iOSTask
//
//  Created by Mohamed Nabil on 16/08/2024.
//

import Foundation
import Combine

final class MovieDetailsViewModel {
    
    // MARK: - Properties
    private let repository: MovieRepository
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Observables
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var movie: Movie?
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func getMovieDetails(movieId: Int) {
        self.isLoading = true
        repository.getMovieDetails(movieId: movieId)
            .sink(receiveCompletion: { [weak self] in
                guard let self else { return }
                switch $0 {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    print("[API logs]: error \(error)")
                }
            }, receiveValue: { [weak self] movie in
                guard let self else { return }
                self.movie = movie
            })
            .store(in: &subscriptions)
        
    }
}
