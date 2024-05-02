//
//  Response.swift
//  Pickleball Match
//
//  Created by Gaganjot Singh on 22/01/24.
//

import Foundation

struct Response<T> {
    let value: T
    let response: URLResponse
    let data: Data
        
    init(value: T, response: URLResponse, data: Data) {
        self.value = value
        self.response = response
        self.data = data
    }
    
    func map<U>(_ closure: (T) throws -> U) rethrows -> Response<U> {
        Response<U>(value: try closure(value), response: response, data: data)
    }
}

extension Response where T == URL {
    var location: URL { value }
}

extension Response: @unchecked Sendable where T: Sendable {}

extension Response {
    var statusCode: Int? {
        (response as? HTTPURLResponse)?.statusCode
    }
}
