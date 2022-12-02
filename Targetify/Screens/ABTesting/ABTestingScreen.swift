//
//  ABTestingScreen.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/25/22.
//

import SwiftUI
import Foundation

struct ABTestingScreen: View {
    
    @ObservedObject var viewModel: ABTestingScreenViewModel
    
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                ForEach(viewModel.testingModels) { model in
                    ABTestingCardView(model: model)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                viewModel.testingModels.removeAll(where: { $0 == model } )
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .transition(.slide.animation(.spring()))
                }
                .listRowSeparator(Visibility.hidden)
                
                ButtonRounded(text: "Add new test") {
                    rootViewModel.showsAddNewTestingModal.toggle()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .listRowSeparator(Visibility.hidden)
            }
            .transition(.slide.animation(.spring()))
            .listRowInsets(EdgeInsets(top: 0, leading: 4, bottom: 4, trailing: 4))
            .listStyle(.plain)
//            .fixedSize(horizontal: false, vertical: true)
        }
        .navigationTitle("A/B Testing")
        .onAppear {
            viewModel.fetchActiveTestings()
        }
    }
}
