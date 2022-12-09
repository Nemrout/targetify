//
//  ProgressView.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/12/22.
//

import SwiftUI

struct ProgressView: View {
    
    var progress: Int
    
    var body: some View {
        
        ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(progress) / 100.0)
                .stroke(Color.blue, lineWidth: 2)
                .animation(.spring(), value: progress)
            
            Text("\(progress)%")
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(progress: 40)
    }
}
