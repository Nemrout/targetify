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

protocol NetworkService {
    
    var domain: String { get }
    
    associatedtype Endpoints: Endpoint
    
}

protocol Endpoint {
    
    var headers: [String : String] { get }
    
    var method: RequestMethod { get }
    
    var urlComponent: String { get }
}
