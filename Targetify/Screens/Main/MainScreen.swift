//
//  Main.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/11/22.
//

import SwiftUI

struct MainScreen: View {
    
    @ObservedObject var viewModel: MainScreenViewModel
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                ForEach(viewModel.configurations) { configuration in
                    let chartData = viewModel.charts[configuration]
                    GenericChart(configuration: configuration, chartData: chartData)
                }
            }
            .padding()
            .padding(.bottom, 60)
        }
        .onTapGesture {
            viewModel.fetchPages()
        }
        .navigationTitle("Dashboard")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Text("Page")
                } label: {
                    Text("Page")
                }

            }
        }
        
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(viewModel: .init())
    }
}

//fileprivate struct UploadingDataView: View {
//
//    @ObservedObject var viewModel: MainScreenViewModel
//
//    var body: some View {
//
//        VStack {
//
//            HStack {
//                Text("Page title")
//
//                Text("Progress")
//            }
//            .font(.headline)
//
//            ForEach(0..<viewModel.pageNames.count, id: \.self) { i in
//
//                let page = viewModel.pageNames[i]
//
//                HStack {
//
//                    Text(page)
//                        .font(.title3)
//
//                    Spacer()
//
//                    ProgressView(progress: viewModel.pageProgress[page] ?? 0)
//                        .frame(width: 50, height: 50, alignment: .center)
//                }
//                .padding()
//                .padding(.horizontal)
//
//            }
//
//        }
//        .frame(width: 200)
//        .padding()
//        .background(
//            RoundedRectangle(cornerRadius: 15, style: .continuous)
//                .stroke(Color.blue, lineWidth: 4)
//        )
//
//    }
//}
//
//fileprivate struct ChoosePageDropdown: View {
//
//    @ObservedObject var viewModel: MainScreenViewModel
//
//    var body: some View {
//        Menu {
//            ForEach(viewModel.pages) { page in
//                Button {
//                    viewModel.selectedPage = page
//                } label: {
//                    Text(page.name)
//                }
//            }
//        } label: {
//            Text(viewModel.selectedPage?.name ?? "Page not selected")
//                .foregroundColor(TargetifyColors.secondary)
//        }
//    }
//}

fileprivate struct DummyChart: View {
    
    var body: some View {
        Rectangle()
            .fill([Color.blue, Color.red, Color.orange].randomElement()!)
            .cornerRadius(15, antialiased: true)
            .padding(.top)
            .aspectRatio(332/174, contentMode: .fit)
    }
}
