//
//  MoviesListViewModel.swift
//  iOSTask
//
//  Created by Mohamed Nabil on 15/08/2024.
//

import Foundation
import Combine

final class MoviesListViewModel {
    
    // MARK: - Properties
    private let repository: MovieRepository
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Observables
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var movies: [Movie]?
    
    private let navigateToDetailsSubject = PassthroughSubject<Int, Never>()
    public var navigateToDetails: AnyPublisher<Int, Never> {
        navigateToDetailsSubject.eraseToAnyPublisher()
    }
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func getPopularMovies() {
        self.isLoading = true
        repository.getPopularMovies()
            .sink(receiveCompletion: { [weak self] in
                guard let self else { return }
                switch $0 {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    print("[API logs]: error \(error)")
                }
            }, receiveValue: { [weak self] movies in
                guard let self else { return }
                self.movies = movies
            })
            .store(in: &subscriptions)
    }
    
    func navigateToDetailsScreen(movieId: Int) {
        navigateToDetailsSubject.send(movieId)
    }
    
}
