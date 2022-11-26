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
        
        ScrollView {
            VStack(spacing: 20) {
                // Page views
                LineChartView(data: dataPoints, title: "Page views")
                    .aspectRatio(332/174, contentMode: .fit)
                
                // Number of clicks
                LineChartView(data: dataPoints, title: "Page views")
                    .aspectRatio(332/174, contentMode: .fit)
                
                // Traffic by country
                PieChart(title: "MyPieChart", data: chartDataSet, separatorColor: Color(UIColor.systemBackground), accentColors: pieColors)
                    .aspectRatio(332/174, contentMode: .fit)
            }
            .padding()
            .padding(.bottom, 60)
        }
        .navigationTitle("Dashboard")
        
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

fileprivate struct DummyChart: View {
    
    var body: some View {
        Rectangle()
            .fill([Color.blue, Color.red, Color.orange].randomElement()!)
            .cornerRadius(15, antialiased: true)
            .padding(.top)
            .aspectRatio(332/174, contentMode: .fit)
    }
}
