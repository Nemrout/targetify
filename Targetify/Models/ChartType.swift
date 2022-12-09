//
//  ChartType.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/12/22.
//

import Combine
import Foundation

enum ChartType: String, Decodable {
    case line
    case pie
    case bar
}

protocol FrequencyChangedProtocol: AnyObject {
    func frequencyChanged(_ chartConfiguration: ChartConfiguration, frequency: Frequency)
}

final class ChartConfiguration: ObservableObject, Equatable, Hashable, Identifiable {
    
    var id: UUID
    
    @Published var frequency: Frequency
    
    @Published var multipleGroups: Bool
    
    let pageTitle: String
    
    let column: String
    
    let chartType: ChartType
    
    let showArea: Bool
    
    var bag: Set<AnyCancellable> = .init()
    
    weak var delegate: FrequencyChangedProtocol?
    
    init(pageTitle: String, column: String, chartType: ChartType, frequency: Frequency, showArea: Bool = true, multipleGroups: Bool = false) {
        self.id = UUID()
        self.pageTitle = pageTitle
        self.column = column
        self.chartType = chartType
        self.frequency = frequency
        self.showArea = showArea
        self.multipleGroups = multipleGroups
        
        self.$frequency
            .sink { [weak self] freq in
                guard let self = self else { return }
                self.delegate?.frequencyChanged(self, frequency: freq)
            }
            .store(in: &bag)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(pageTitle)
        hasher.combine(column)
    }
    
    static func == (lhs: ChartConfiguration, rhs: ChartConfiguration) -> Bool {
        lhs.pageTitle == rhs.pageTitle && lhs.column == rhs.column
    }
}
