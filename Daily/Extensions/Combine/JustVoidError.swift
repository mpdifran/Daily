//
//  JustVoidError.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Combine

func JustVoidError() -> AnyPublisher<Void, Error> {
    Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
}
