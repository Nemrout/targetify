//
//  AddNewTestingModal.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/25/22.
//

import SwiftUI
import Foundation

struct AddNewTestingModal: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: AddNewTestingModalViewModel = .init()
    
    @ObservedObject var screenViewModel: ABTestingScreenViewModel
    
    @FocusState var focused: Bool
    
    var body: some View {
        
        VStack(spacing: 12) {
            
            Text("New A/B Testing")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.leading)
                .padding(.top)
            
            
            TextField("Title of the testing...", text: $viewModel.title)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(Color.black, style: StrokeStyle(lineWidth: 3))
                )
                .focused($focused)
                .padding(.horizontal)
            
            Dropdown(viewModel: viewModel)
            
            Group {
                if let selectedPageContainer = viewModel.selectedPageContainer {
                    ForEach(selectedPageContainer.versions) { version in
                        HStack {
                            Text(version.description)
                            
                            Spacer()
                            
                            Checkbox(isEnabled: viewModel.selectedPageVersions.contains(version)) {}
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if let found = viewModel.selectedPageVersions.firstIndex(where: { $0 == version }) {
                                viewModel.selectedPageVersions.remove(at: found)
                            } else {
                                viewModel.selectedPageVersions.append(version)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(8, antialiased: true)
                        .padding(.horizontal)
                    }
                    .animation(.spring(), value: viewModel.selectedPageVersions)
                    .transition(.opacity)
                    
                } else {
                    ForEach(0..<5) { ind in
                        HStack {
                            Text("This is a long text")
                            
                            Spacer()
                            
//                            Checkbox(isEnabled: true, onTap: {})
                        }
                        .padding(.horizontal)
                        .redacted(reason: .placeholder)
                        .padding(.horizontal)
                    }
                }
            }
            .animation(.spring(), value: viewModel.selectedPageVersions)
            
            ButtonRounded(text: "Submit") {
                presentationMode.wrappedValue.dismiss()
                viewModel.submit()
            }
            
            Spacer()
        }
        .onTapGesture {
            focused = false
        }
    }
}

fileprivate struct Dropdown: View {
    
    @ObservedObject var viewModel: AddNewTestingModalViewModel
    
    var body: some View {
        Menu {
            ForEach(viewModel.pageContainers) { container in
                Button {
                    withAnimation(.spring()) {
                        viewModel.selectedPageContainer = container
                    }
                } label: {
                    Text(container.pageName)
                        .bold()
                }

            }
        } label: {
            Group {
                if let selected = viewModel.selectedPageContainer {
                    Text(selected.pageName)
                        .bold()
                } else {
                    Text("Choose Page")
                        .bold()
                }
            }
            .frame(width: 120)
            .padding()
            .foregroundColor(TargetifyColors.secondary)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.white)
                    .shadow(radius: 5)
            )
        }
    }
}

fileprivate struct Checkbox: View {
    
    var isEnabled: Bool
    
    let onTap: () -> ()
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.black)
                .frame(width: 24, height: 24, alignment: .center)
            
            if isEnabled {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .center)
                    .foregroundColor(.blue)
                    .cornerRadius(12)
            }
            
        }
        .animation(.spring(), value: isEnabled)
        .frame(width: 24, height: 24, alignment: .center)
//        .onTapGesture {
//            onTap()
//        }
    }
    
}
