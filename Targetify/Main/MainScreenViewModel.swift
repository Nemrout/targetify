//
//  MainScreenViewModel.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/12/22.
//

import Combine
import Foundation

final class MainScreenViewModel: ObservableObject {
    
    let firebaseService: FirebaseService = FirebaseService()
    
    @Published var pageProgress: [String : Int] = [:]
    
    var pageNames: [String] {
        Array(pageProgress.keys)
    }
    
    var bag: Set<AnyCancellable> = .init()
    
    init() {
        
        Task {
            do {
                let files = try await firebaseService.allFiles
                let pageNames = files.map { $0.pageName }
                let progresses: [Int] = Array(repeating: 0, count: pageNames.count)
                let zip = zip(pageNames, progresses)
                
                DispatchQueue.main.async {
                    self.pageProgress = Dictionary(uniqueKeysWithValues: zip)
                }
                
            } catch {}
        }
        
        
        firebaseService.progressPublisher
            .sink { [weak self] progress in
                DispatchQueue.main.async {
                    print(progress)
                    switch progress {
                    case .progress(let pageName, let fraction):
                        let percent = Int(fraction * 100)
                        self?.pageProgress[pageName] = percent
                        
                    case .failure(let pageName):
                        self?.pageProgress[pageName] = -1
                        
                    case .success(let pageName):
                        self?.pageProgress[pageName] = 101
                    }
                }
            }
            .store(in: &bag)
    }
}
