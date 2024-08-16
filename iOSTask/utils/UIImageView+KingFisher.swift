//
//  UIImageView+KingFisher.swift
//  iOSTask
//
//  Created by Mohamed Nabil on 15/08/2024.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    private var imagesBaseUrl: String {
        "https://image.tmdb.org/t/p/w200"
    }
    
    func loadImage(url: String) {
        guard let imageUrl = URL(string: imagesBaseUrl.appending("\(url)")) else { return }
        let placeholderImage = UIImage(systemName: "photo.fill")?.withRenderingMode(.alwaysTemplate)
        
        kf.cancelDownloadTask()
        kf.setImage(
            with: KF.ImageResource(downloadURL: imageUrl, cacheKey: nil),
            placeholder: placeholderImage,
            options: nil,
            progressBlock: nil,
            completionHandler: nil
        )
    }
    
}
