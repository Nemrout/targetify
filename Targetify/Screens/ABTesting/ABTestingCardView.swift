//
//  ABTestingCardView.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/25/22.
//

import SwiftUI

struct ABTestingCardView: View {
    
    let model: ABTestingModel
    
    var body: some View {
        
        GeometryReader { geo in
            VStack {
                HStack {
                    Text(model.title)
                    
                    Spacer()
                    
                    HStack {
                        
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                        
                        if model.isLive {
                            Text("Live")
                        }
                    }
                }
                
                Rectangle()
                    .fill(Color.blue)
            }
            .frame(width: geo.size.width, height: geo.size.width * 185 / 330)
        }
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.secondary)
        )
    }
}

//struct ABTestingCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ABTestingCardView()
//    }
//}
