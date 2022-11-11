//
//  AuthViewModel.swift
//  Targetify
//
//  Created by Петрос Тепоян on 10/3/22.
//

import Foundation

final class AuthViewModel: ObservableObject {
    
    @Published var loginText: String = ""
    
    @Published var passwordText: String = ""
    
}
