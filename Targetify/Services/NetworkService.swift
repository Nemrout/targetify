//
//  NetworkService.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/11/22.
//

import Foundation

enum RequestMethod: String {
    case post = "POST"
    case get = "GET"
}

enum NetworkError: Error {
    case cantBuildURLRequest
}

protocol NetworkService {
    
    var domain: String { get }
    
    associatedtype Endpoints: Endpoint
    
}

protocol Endpoint {
    
    var headers: [String : String] { get }
    
    var method: RequestMethod { get }
    
    var urlComponent: String { get }
}

extension NetworkService {
    
    func buildRequest(for endpoint: Endpoint) throws -> URLRequest {
        let string = domain + endpoint.urlComponent
        
        guard let url = URL(string: string) else {
            throw NetworkError.cantBuildURLRequest
        }
        
        let request = URLRequest(url: url)
        
        return request
    }
    
    func request(endpoint: Endpoint, delegate: URLSessionTaskDelegate?) async throws -> Data {
        let request = try buildRequest(for: endpoint)
        let (data, _) = try await URLSession.shared.data(for: request, delegate: delegate)
        return data
    }
}
