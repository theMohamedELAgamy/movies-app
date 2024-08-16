//
//  Publisher+asFuture.swift
//  iOSTask
//
//  Created by Mohamed Nabil on 16/08/2024.
//

import Foundation
import Combine

public extension Publisher {
    func asFuture() -> Future<Output, Failure> {
        return Future { promise in
            var ticket: AnyCancellable?
            ticket = self.sink(
                receiveCompletion: {
                    ticket?.cancel()
                    ticket = nil
                    switch $0 {
                    case .failure(let error):
                        promise(.failure(error))
                    case .finished: break
                    }
            },
                receiveValue: {
                    ticket?.cancel()
                    ticket = nil
                    promise(.success($0))
            })
        }
    }
}
