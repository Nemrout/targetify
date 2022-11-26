//
//  ABTestingScreen.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/25/22.
//

import SwiftUI
import Foundation

struct ABTestingScreen: View {
    
    @ObservedObject var viewModel: ABTestingScreenViewModel = .init()
    
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(viewModel.testingModels) { model in
                ABTestingCardView(model: model)
                    .padding(.all, 15)
            }
            
            ButtonRounded(text: "Add new test") {
                rootViewModel.showsAddNewTestingModal.toggle()
            }
        }
        .padding()
        .navigationTitle("A/B Testing")
    }
}
