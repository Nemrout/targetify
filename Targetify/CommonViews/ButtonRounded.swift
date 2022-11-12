//
//  ButtonRounded.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/12/22.
//

import SwiftUI

struct ButtonRounded: View {
    
    let text: String
    
    let action: () -> ()
    
    var body: some View {
        
        Button(action: action) {
            Text(text)
                .padding()
                .background(TargetifyColors.primary)
                .foregroundColor(.white)
                .cornerRadius(15)
        }
    }
}

struct ButtonRounded_Previews: PreviewProvider {
    static var previews: some View {
        ButtonRounded()
    }
}
