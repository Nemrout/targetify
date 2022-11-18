//
//  FlaskService.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/16/22.
//

import Combine
import Foundation

final class FlaskService: NSObject, NetworkService {
    
    var domain: String = Config.isDebug ? "http://127.0.0.1:8000" : "https://targetify-app.herokuapp.com"
    
    var progressPublisher: PassthroughSubject<CGFloat, Never> = .init()
    
    private let jsonDecoder = JSONDecoder()
    
    func fetchPages() async throws -> [String] {
        let data = try await self.request(endpoint: Endpoints.pages, delegate: self)
        let pages = try jsonDecoder.decode([String].self, from: data)
        return pages
    }
    
    func fetchPage(name: String) async throws -> Page {
        let data = try await self.request(endpoint: Endpoints.page(name: name), delegate: self)
        let pageData = try PageData(data: data)
        let page = Page(name: name, data: pageData)
        return page
    }
    
    enum Endpoints: Endpoint {
        
        case pages
        
        case page(name: String)
        
        var headers: [String : String] {
            [:]
        }
        
        var method: RequestMethod {
            .get
        }
        
        var urlComponent: String {
            switch self {
            case let .page(name):
                return "/page?name=\(name)"
            default:
                return "/pages"
            }
        }
    }
}

extension FlaskService: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let fraction = CGFloat(bytesWritten) / CGFloat(totalBytesWritten)
        print(fraction)
        progressPublisher.send(fraction)
    }
}
