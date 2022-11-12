//
//  Main.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/11/22.
//

import SwiftUI

struct MainScreen: View {
    
    @ObservedObject var viewModel: MainScreenViewModel = .init()
    
    var body: some View {
        
        Group {
            if viewModel.finishedDownloadingFiles {

                VStack(alignment: .leading) {

                    ZStack(alignment: .topLeading) {
                        
                        LineChartView(page: viewModel.selectedPage)
                            .frame(height: 300)
                        
                        ChoosePageDropdown(viewModel: viewModel)
                    }
                    
                    NavigationLink {
                        NewsScreen()
                    } label: {
                        Text("News")
                            .padding()
                            .background(TargetifyColors.primary)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 44)
                            .cornerRadius(22)
                    }
                }


            } else {
                UploadingDataView(viewModel: viewModel)
            }
        }
        .transition(.opacity.combined(with: .scale).animation(.easeInOut))
        .animation(.easeInOut, value: viewModel.finishedDownloadingFiles)
        
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}

fileprivate struct UploadingDataView: View {
    
    @ObservedObject var viewModel: MainScreenViewModel
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text("Page title")
                
                Text("Progress")
            }
            .font(.headline)
            
            ForEach(0..<viewModel.pageNames.count, id: \.self) { i in
                
                let page = viewModel.pageNames[i]
                
                HStack {
                    
                    Text(page)
                        .font(.title3)
                    
                    Spacer()
                    
                    ProgressView(progress: viewModel.pageProgress[page] ?? 0)
                        .frame(width: 50, height: 50, alignment: .center)
                }
                .padding()
                .padding(.horizontal)
                
            }
            
        }
        .frame(width: 200)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(Color.blue, lineWidth: 4)
        )
        
    }
}

fileprivate struct ChoosePageDropdown: View {
    
    @ObservedObject var viewModel: MainScreenViewModel
    
    var body: some View {
        Menu {
            ForEach(viewModel.pages) { page in
                Button {
                    viewModel.selectedPage = page
                } label: {
                    Text(page.name)
                }
            }
        } label: {
            Text(viewModel.selectedPage?.name ?? "Page not selected")
                .foregroundColor(TargetifyColors.secondary)
        }
    }
}
