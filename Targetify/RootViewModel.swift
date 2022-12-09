//
//  RootViewModel.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/26/22.
//

import Combine
import Foundation

final class RootViewModel: ObservableObject {
    @Published var showsAddNewTestingModal: Bool = false
    
    static var subject = PassthroughSubject<[String : String], Never>()
}

