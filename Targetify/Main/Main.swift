//
//  Main.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/11/22.
//

import SwiftUI

struct Main: View {
    
    @ObservedObject var viewModel: MainScreenViewModel = .init()
    
    var body: some View {
        UploadingDataView(viewModel: viewModel)
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}

struct UploadingDataView: View {
    
    @ObservedObject var viewModel: MainScreenViewModel
    
    var body: some View {
        ForEach(0..<viewModel.pageNames.count, id: \.self) { i in
            
            let page = viewModel.pageNames[i]
            
            HStack {
                Text(page)
                
                Text(String(viewModel.pageProgress[page] ?? 0))
            }
        }
    }
}
