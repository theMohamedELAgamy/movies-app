//
//  Enviroment.swift
//  iOSTask
//
//  Created by Mohamed Nabil on 15/08/2024.
//

import Foundation

public enum Environment {
    
    enum Keys {
        static let moviesAPIKey = "Movies Api Key"
        static let moviesAPIToken = "Movies Api Token"
    }
    
    private static let infoDict: [String: Any]? = {
        return Bundle.main.infoDictionary
    }()
    
    public static let moviesAPIKey: String? = {
        return Environment.infoDict?[Keys.moviesAPIKey] as? String
    }()
    
    public static let moviesAPIToken: String? = {
        return Environment.infoDict?[Keys.moviesAPIToken] as? String
    }()
    
}
