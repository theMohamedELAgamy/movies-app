//
//  Request.swift
//  iOSTask
//
//  Created by Mohamed Nabil on 15/08/2024.
//

import Foundation
import Alamofire
import Combine

class BaseWebClient {
    
    private let baseURL = "https://api.themoviedb.org/3"
    
    func request<T: Decodable>(url: String, method: HTTPMethod = .get) -> Future<T, AFError> {
        let headers = makeRequestHeaders()
        
        return Future { promise in
            AF.request(self.baseURL.appending(url), method: method, headers: headers)
                .response{ response in
                    print("[API logs]: Headers: \(String(describing: response.request?.headers))")
                }
                .responseDecodable(of: T.self) { response in
                    print("[API logs]: decoded response: \(String(describing: response.result))")
                    switch response.result {
                    case .success(let result):
                        promise(.success(result))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
                .cURLDescription { cURL in
                    print("[API logs]: cURL \(String(describing: cURL))")
                }
        }
    }
    
    
    private func makeRequestHeaders() -> HTTPHeaders {
        let token = Environment.moviesAPIToken ?? ""
        return [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
    }
    
}
