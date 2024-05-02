//
//  Request.swift
//  Pickleball Match
//
//  Created by Gaganjot Singh on 22/01/24.
//

import Foundation

enum HTTPMethod: String {
    case POST
    case GET
    case DELETE
    case PATCH
    case PUT
}

struct Request<Response> {
    var url: URL?

    var method: HTTPMethod
    var query: [(String, String?)]?
    var body: Encodable?
    var headers: [String: String]?
    
    init(url: URL? = nil, method: HTTPMethod, query: [(String, String?)]? = nil, body: Encodable? = nil, headers: [String : String]? = nil) {
        self.method = method
        self.url = url
        self.query = query
        self.body = body
        self.headers = headers
    }
    
    init(path: String, method: HTTPMethod, query: [(String, String?)]? = nil, body: Encodable? = nil, headers: [String : String]? = nil) {
        self.method = method
        self.url = URL(string: path.isEmpty ? "/" : path)
        self.query = query
        self.body = body
        self.headers = headers
    }
}

extension Request where Response == Void {
    init(url: URL? = nil, method: HTTPMethod, query: [(String, String?)]? = nil, body: Encodable? = nil, headers: [String : String]? = nil) {
        self.method = method
        self.url = url
        self.query = query
        self.body = body
        self.headers = headers
    }
    
    init(path: String, method: HTTPMethod, query: [(String, String?)]? = nil, body: Encodable? = nil, headers: [String : String]? = nil) {
        self.method = method
        self.url = URL(string: path.isEmpty ? "/" : path)
        self.query = query
        self.body = body
        self.headers = headers
    }
}
