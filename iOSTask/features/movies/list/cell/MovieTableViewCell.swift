//
//  MovieTableViewCell.swift
//  iOSTask
//
//  Created by Mohamed Nabil on 15/08/2024.
//

import Foundation
import UIKit

final class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Views
    @IBOutlet weak var movieIV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    static let identifier = "MovieTableViewCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.resetViews()
    }
    
    func setup(movie: Movie) {
        movieIV.loadImage(url: movie.posterPath ?? "")
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview
    }
    
    private func resetViews() {
        movieIV.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
    
}
