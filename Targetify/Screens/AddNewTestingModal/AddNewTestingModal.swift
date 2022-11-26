//
//  AddNewTestingModal.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/25/22.
//

import SwiftUI
import Foundation

struct AddNewTestingModal: View {
    
    @ObservedObject var viewModel: AddNewTestingModalViewModel = .init()
    
    var body: some View {
        
        VStack {
            
            DropdownField(viewModel: viewModel, type: .page)
            
            DropdownField(viewModel: viewModel, type: .version)
            
            ButtonRounded(text: "Add new test", action: {})
                .disabled(viewModel.selectedPage != nil && viewModel.selectedVersion != nil)
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.gray)
        )
        

    }
}

enum DropdownFieldType {
    case page
    case version
}

fileprivate struct DropdownField: View {
    
    @ObservedObject var viewModel: AddNewTestingModalViewModel
    
    let type: DropdownFieldType
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Version")
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Menu {
                ForEach(type == .page ? viewModel.pages : viewModel.versions, id: \.self) { string in

                    Button {
                        if type == .page {
                            viewModel.selectedPage = string
                        } else {
                            viewModel.selectedVersion = string
                        }
                    } label: {
                        Text(string)
                    }

                }
            } label: {
                HStack {
                    if type == .page {
                        if let selectedPage = viewModel.selectedPage {
                            Text(selectedPage)
                                .bold()
                        } else {
                            Text("Select Page")
                        }
                    } else {
                        if let selectedVersion = viewModel.selectedVersion {
                            Text(selectedVersion)
                                .bold()
                        } else {
                            Text("Select Version")
                        }
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                }
                .padding()
                .foregroundColor(TargetifyColors.secondary)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.white)
                        .shadow(radius: 5)
                )
                .frame(height: 44)
            }
        }
    }
}
