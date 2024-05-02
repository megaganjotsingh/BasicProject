//
//  NetworkManager.swift
//  Pickleball Match
//
//  Created by Gaganjot Singh on 22/01/24.
//

import Foundation

actor NetworkManager {
    
    nonisolated let configuration: Configuraton
    nonisolated let session: URLSession
    
    
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    struct Configuraton: @unchecked Sendable {
        var baseURL: URL?
        var sessionConfiguration: URLSessionConfiguration
        var decoder: JSONDecoder
        var encoder: JSONEncoder
        
        init(baseURL: URL?, sessionConfiguration: URLSessionConfiguration = .default) {
            self.baseURL = baseURL
            self.sessionConfiguration = sessionConfiguration
            self.decoder = JSONDecoder()
            self.encoder = JSONEncoder()
        }
    }
    
    init(configuration: NetworkManager.Configuraton) {
        self.configuration = configuration
        self.session = URLSession(configuration: configuration.sessionConfiguration)
        self.decoder = JSONDecoder()
        self.encoder = JSONEncoder()
    }
    
    
    init(baseURL: URL? = nil, _ configure: @Sendable (inout NetworkManager.Configuraton) -> Void = { _ in } ) {
        var configuration = Configuraton(baseURL: baseURL)
        configure(&configuration)
        
        self.init(configuration: configuration)
    }
    
    @discardableResult
    func send<T: Decodable>(
        _ request: Request<T>,
        configure: ((inout URLRequest) throws -> Void)? = nil
    ) async throws -> Response<T> {
        let response = try await data(for: request, configure: configure)
        let value = try decoder.decode(T.self, from: response.data)
        return response.map({ _ in value })
    }
    
    @discardableResult
    func send(
        _ request: Request<Void>,
        configure: ((inout URLRequest) throws -> Void)? = nil
    ) async throws -> Response<Void> {
        try await data(for: request, configure: configure).map({ _ in () })
    }
    
    @discardableResult
    func data<T>(
        for request: Request<T>,
        configure: ((inout URLRequest) throws -> Void)? = nil
    ) async throws -> Response<Data> {
        let request = try await makeURLRequest(for: request, configure)
        
        return try await performRequest {
            let (data, urlRes) = try await self.session.data(for: request)
            let response = Response(value: data, response: urlRes, data: data)
            
            return response
        }
    }
    
    private func makeURLRequest<T>(
        for request: Request<T>,
        _ configure: ((inout URLRequest) throws -> Void)?
    ) async throws -> URLRequest {
        let url = try makeURL(for: request)
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpMethod = request.method.rawValue
        
        if let body = request.body {
            urlRequest.httpBody = try encoder.encode(body)
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }
        
        if let configure {
            try configure(&urlRequest)
        }
        return urlRequest
    }
    
    private func makeURL<T>(for request: Request<T>) throws -> URL {
        func makeURL() -> URL? {
            guard let url = request.url else {
                return nil
            }
            return url.scheme == nil ? configuration.baseURL?.appendingPathComponent(url.absoluteString) : url
        }
        
        guard let url = makeURL(), var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        if let query = request.query, !query.isEmpty {
            components.queryItems = query.map(URLQueryItem.init)
        }
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        return url
    }
    
    private func performRequest<T>(attempts: Int = 1, send: () async throws -> T) async throws -> T {
        return try await send()
    }
}
