//
//  AuthScreen.swift
//  Targetify
//
//  Created by Петрос Тепоян on 10/3/22.
//

import SwiftUI

struct AuthScreen: View {
    
    @ObservedObject var viewModel: AuthViewModel = AuthViewModel()
    
    @FocusState var loginInFocus: Bool
    
    @FocusState var passwordInFocus: Bool
    
    var body: some View {
        
        VStack {
            AuthTextField(placeholder: "Login", text: $viewModel.loginText, isSecure: false)
            
            AuthTextField(placeholder: "Password", text: $viewModel.passwordText, isSecure: true)
        }
        .padding()
        
        
    }
}

struct AuthScreen_Previews: PreviewProvider {
    static var previews: some View {
        AuthScreen()
    }
}

struct AuthTextField: View {
    
    let placeholder: String
    
    @Binding var text: String
    
    let isSecure: Bool
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.blue.opacity(0.7))
        .cornerRadius(20, antialiased: true)
    
        .autocorrectionDisabled(true)
    }
}
