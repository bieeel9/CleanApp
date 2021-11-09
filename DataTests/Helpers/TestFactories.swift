//
//  TestFactories.swift
//  DataTests
//
//  Created by Gabriel Santos on 27/10/21.
//

import Foundation

func makeInvalidData() -> Data {
    return Data("invalid_data".utf8)
}

func makeURL() -> URL {
    return URL(string: "www.google.com.br")!
}