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
            
            DropdownField(viewModel: viewModel)
            
            DropdownField(viewModel: viewModel)
            
            ButtonRounded(text: "Add new test", action: {})
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.gray)
        )
        

    }
}

fileprivate struct DropdownField: View {
    
    @ObservedObject var viewModel: AddNewTestingModalViewModel
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Version")
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Menu {
                ForEach(viewModel.pages, id: \.self) { page in

                    Button {
                        viewModel.selectedPage = page
                    } label: {
                        Text(page)
                    }

                }
            } label: {
                HStack {
                    Text("Select Page")
                    
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
