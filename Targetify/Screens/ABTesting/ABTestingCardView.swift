//
//  ABTestingCardView.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/25/22.
//

import SwiftUI

struct ABTestingCardView: View {
    
    let model: ABTestingModel
    
    var body: some View {
        GenericChart(configuration: model.configuraiton, chartData: model.data)
    }
}

//struct ABTestingCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ABTestingCardView()
//    }
//}
