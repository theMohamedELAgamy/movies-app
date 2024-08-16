//
//  SceneDelegate.swift
//  iOSTask
//
//  Created by Mohamed Nabil on 15/08/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        
        let splashFactory = AppDependancyContainer.shared.makeSplashViewController()
        window?.rootViewController = UINavigationController(rootViewController: splashFactory)
        
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        
        guard let url = connectionOptions.urlContexts.first?.url else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
            self.openUrl(url)
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        openUrl(url)
    }
    
    
    private func openUrl(_ url: URL) {
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
        let pathParts = components.path?.components(separatedBy: "/") else { return }
        
        if pathParts.count >= 2 && pathParts[0] == "movie_details" {
            let movieId = Int(pathParts[1])
            
            NotificationCenter.default.post(
                name: Notification.Name("openMovieDetails"),
                object: nil,
                userInfo: ["movieId": movieId]
            )
        }
    }
}

