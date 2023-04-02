//
//  CNURLSession.swift
//  Daily
//
//  Created by Mark DiFranco on 2023-04-02.
//

import Foundation
import Combine

protocol CNURLSession: AnyObject {

    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<Data, Error>
}

