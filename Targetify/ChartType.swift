//
//  ChartType.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/12/22.
//

import Foundation

enum ChartType: String, Decodable {
    case line
    case pie
    case bar
}

final class ChartConfiguration: ObservableObject, Equatable, Hashable, Identifiable {
    
    let id: UUID
    
    @Published var frequency: Frequency
    
    let pageTitle: String
    
    let column: String
    
    let chartType: ChartType
    
    let showArea: Bool
    
    init(pageTitle: String, column: String, chartType: ChartType, frequency: Frequency, showArea: Bool = true) {
        self.id = UUID()
        self.pageTitle = pageTitle
        self.column = column
        self.chartType = chartType
        self.frequency = frequency
        self.showArea = showArea
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ChartConfiguration, rhs: ChartConfiguration) -> Bool {
        lhs.id == rhs.id
    }
}
