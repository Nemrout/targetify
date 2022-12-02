//
//  NewsService.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/11/22.
//

import Combine
import Foundation

final class NewsService: NSObject, NetworkService {
    
    @InfoPlistWrapper(key: .newsApi) var key
    
    var domain: String = "https://newsapi.org/v2/everything"
    
    var progressPublisher: PassthroughSubject<Int, Never> = .init()
    
    private var observer: NSKeyValueObservation?
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let delegateQueue = OperationQueue()
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: delegateQueue)
        return session
    }()
    
    private func buildRequest(for endpoint: Endpoints) throws -> URLRequest {
        
        guard let key = key else { throw Errors.missingAPIKey }
        
        let string = domain + "?" + endpoint.urlComponent + "&apiKey=\(key)"
        
        guard let url = URL(string: string) else { throw Errors.buildingRequestError }
        
        return URLRequest(url: url)
    }
    
    func request<T: Decodable>(endpoint: Endpoints) async throws -> T {
        
        let request = try buildRequest(for: endpoint)
        
        let dataTask = session.dataTask(with: request)

        observer = dataTask.progress.observe(\.fractionCompleted) { [weak self] progress, _ in
            self?.progressPublisher.send(Int(progress.fractionCompleted * 100))
        }
            
        dataTask.resume()
        
        let (data, _) = try await session.data(for: request, delegate: self)
        
        let decoder = JSONDecoder()
        
        return try decoder.decode(T.self, from: data)
    }
    
    func fetchNews() async throws -> [Article] {
        let response: NewsRequestResponse = try await request(endpoint: .everything(keywords: keywords))
        return response.articles
    }
    
    private let keywords: [String] = [
        "marketing"
    ]
    
//    private let keywords: [String] = [
//        "marketing trends",
//        "marketing tools",
//        "marketing ideas",
//        "website optimization",
//        "website traffic",
//        "increase traffic",
//        "marketing campaign"
//    ]
    
    enum Endpoints: Endpoint {
        
        var data: Data? { nil }
        
        case everything(keywords: [String])
        
        var headers: [String : String] {
            [:]
        }
        
        var method: RequestMethod {
            switch self {
            case .everything:
                return .get
            }
        }
        
        var urlComponent: String {
            switch self {
            case let .everything(keywords):
                let keywordsJoined = keywords
//                    .map { "\"" + $0 + "\"" }
                    .joined(separator: "OR")
                
                return "q=(\(keywordsJoined))"
            }
        }
        
        
    }
    
    enum Errors: Error {
        case buildingRequestError
        case missingAPIKey
    }
}

extension NewsService: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {}
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//        print(bytesWritten / totalBytesWritten)
        print(bytesWritten / totalBytesExpectedToWrite)
    }

}
