//
//  FirebaseService.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/11/22.
//

import Foundation
import SwiftCSV
import FirebaseStorage

final class FirebaseService {
    
    var domain: String = "gs://targetify-8323e.appspot.com"
    
    private lazy var storage: Storage = Storage.storage(url: domain)
    
    func getFiles() async throws -> [NamedCSV] {
        let reference = storage.reference(withPath: "page_login.csv")
        
        let decoder = CSVDecoder()
        return []
//        try await withUnsafeThrowingContinuation { continuation in
//            reference.getData(maxSize: 10 * 1024 * 1024) { data, error in
//                if let error = error {
//                    continuation.resume(throwing: error)
//                    return
//                }
//
//                guard let data = data else {
//                    continuation.resume(throwing: CSVDecoder.DecodingError.curruptedData)
//                    return
//                }
//
//                do {
//                    let csv: PageData = try decoder.decode(from: data)
//                    continuation.resume(returning: csv)
//                } catch {
//                    continuation.resume(throwing: error)
//                }
//            }
//        }
    }
}
