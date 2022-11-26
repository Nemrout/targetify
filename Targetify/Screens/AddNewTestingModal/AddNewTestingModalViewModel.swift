//
//  AddNewTestingModalViewModel.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/26/22.
//

import Foundation

final class AddNewTestingModalViewModel: ObservableObject {
    
    @Published var pages: [String] = ["login", "main", "pricing"]
    
    @Published var versions: [String] = ["red button vs. blue button", "pink button vs. orange button"]
    
    @Published var selectedPage: String?
    
    @Published var selectedVersion: String?
}
