//
//  FirebaseService.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/11/22.
//

import Combine
import SwiftCSV
import Foundation
import FirebaseStorage

final class FirebaseService {
    
    private let domain: String = "gs://targetify-8323e.appspot.com"
    
    enum DownloadProgress {
        case failure(String)
        case success(String)
        case progress(String, CGFloat)
    }
    
    let progressPublisher: PassthroughSubject<DownloadProgress, Never> = .init()
    
    init() {
        
    }
    
    private lazy var storage: Storage = Storage.storage(url: domain)
    
    var allFiles: [StorageReference] {
        get async throws {
            try await storage.reference().listAll().items
        }
    }
    
    func fetchPages() async throws -> [Page] {
        
        let files = try await allFiles
        
        var pages: [Page] = []
        
        for file in files {
            let page = try await download(file: file)
            pages.append(page)
        }
        
        return pages
    }
    
    func download(file: StorageReference) async throws -> Page {
        
        let pageName: String = file.pageName
        
        return try await withUnsafeThrowingContinuation { continuation in
            let downloadTask = file.getData(maxSize: 10 * 1024 * 1024) { data, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let data = data else {
                    continuation.resume(throwing: CSVDecoder.DecodingError.curruptedData)
                    return
                }

                do {
                    let csv: PageData = try PageData(data: data)
                    let page = Page(name: pageName, data: csv)
                    continuation.resume(returning: page)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
            
            // Progress
            downloadTask.observe(.progress) { [weak self] snapshot in
                if let progress = snapshot.progress?.fractionCompleted {
                    self?.progressPublisher.send(.progress(pageName, progress))
                }
            }
            
            // Failure
            downloadTask.observe(.failure) { [weak self] _ in
                self?.progressPublisher.send(.failure(pageName))
            }
            
            // Success
            downloadTask.observe(.success) { [weak self] _ in
                self?.progressPublisher.send(.success(pageName))
            }
        }
    }
}

extension StorageReference {
    var pageName: String {
        String(self.name
            .split(separator: ".")
            .first?
            .split(separator: "_")
            .last ?? "page")
    }
}
