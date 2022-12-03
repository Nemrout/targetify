//
//  FlaskService.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/16/22.
//

import Combine
import Foundation

final class FlaskService: NSObject, NetworkService {
    
    var domain: String = Config.isDebug ? "http://127.0.0.1:8000" : "https://web-production-8f2e.up.railway.app"
    
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
    
    func fetchChartData(page: String, frequency: String, column: String, chartType: ChartType, group: String?) async throws -> ChartData {
        let endpoint = Endpoints.chartData(page: page, frequency: frequency, column: column, chartType: chartType, group: group)
        let data = try await self.request(endpoint: endpoint, delegate: self)
        let chartData = try jsonDecoder.decode(ChartData.self, from: data)
        return chartData
    }
    
    func fetchPagesVersions() async throws -> [PageVersion] {
        let endpoint = Endpoints.chartsInfo
        let data = try await self.request(endpoint: endpoint, delegate: self)
        let chartData = try jsonDecoder.decode([PageVersion].self, from: data)
        return chartData
    }
    
    func fetchActiveTestings() async throws -> [BFFAbTestingModel] {
        let endpoint = Endpoints.activeTestings
        let data = try await self.request(endpoint: endpoint, delegate: self)
        let testings = try jsonDecoder.decode([BFFAbTestingModel].self, from: data)
        return testings
    }
    
    func createABTesting(requestModel: BFFAbTestingModel) async throws {
        let endpoint = Endpoints.createTesting(requestModel: requestModel)
        let data = try await self.request(endpoint: endpoint, delegate: self)
        print(String(data: data, encoding: .utf8))
    }
    
    enum Endpoints: Endpoint {
        
        case pages
        
        case page(name: String)
        
        case chartData(page: String, frequency: String, column: String, chartType: ChartType, group: String?)
        
        case chartsInfo
        
        case activeTestings
        
        case createTesting(requestModel: BFFAbTestingModel)
        
        var headers: [String : String] {
            [:]
        }
        
        var method: RequestMethod {
            switch self {
            case .chartData, .createTesting:
                return .post
            default:
                return .get
            }
        }
        
        var urlComponent: String {
            switch self {
            case let .page(name):
                return "/page?name=\(name)"
            case .chartData:
                return "/chart_data"
            case .chartsInfo:
                return "/pages_info"
            case .activeTestings:
                return "/active_testings"
            case .createTesting:
                return "/create_ab_testing"
            default:
                return "/pages"
            }
        }
        
        var data: Data? {
            switch self {
            case let .chartData(page, frequency, column, chartType, group):
                var dict = [
                    "page" : page,
                    "chart_type" : chartType.rawValue,
                    "freq" : frequency,
                    "column" : column
                ]
                
                if let group = group {
                    dict["groups"] = group
                }
                
                let data = try? JSONSerialization.data(withJSONObject: dict)
                return data
                
            case let .createTesting(model):
                let dict = [
                    "title" : model.page,
                    "groups" : String(model.groups),
                    "page" : model.page
                ]
                
                let data = try? JSONSerialization.data(withJSONObject: dict)
                
                return data
                
            default:
                return nil
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
