//
//  FrequencyPicker.swift
//  Targetify
//
//  Created by Петрос Тепоян on 12/3/22.
//

import SwiftUI

struct FrequencyPicker: View {
    
    @Binding var frequency: Frequency
    
    @State var manualPeriod: String = "D"
    
    @State var manualCount: String = "1"
    
    @State var expanded: Bool = false
    
    var body: some View {
        HStack {
            Group {
                if expanded {
                    WheelFreqPicker(period: $manualPeriod, count: $manualCount)
                } else {
                    Picker("Pick", selection: $frequency) {
                        ForEach(Frequency.common) { freq in
                            Text(freq.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            
            
            Image(systemName: "gear.circle.fill")
                .resizable()
                .frame(width: 24, height: 24, alignment: .center)
                .onTapGesture {
                    withAnimation(.spring()) {
                        expanded.toggle()
                    }
                }
            
        }
        
    }
}

struct FrequencyPicker_Previews: PreviewProvider {
    
    @State static var freq: Frequency = .H1
    
    static var previews: some View {
        FrequencyPicker(frequency: .constant(.H1))
            .padding()
    }
}

fileprivate struct WheelFreqPicker: View {
    
    @Binding var period: String
    
    @Binding var count: String
    
    private let counts: [Int] = [1,2,3,4,5,6]
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Picker(selection: self.$period, label: Text("")) {
                    ForEach(0..<Frequency.Period.longListed.count, id: \.self) { i in
                        Text(Frequency.Period.longListed[i]).tag(i)
                    }
                }
                    .pickerStyle(.wheel)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height, alignment: .center)
                    .compositingGroup()
                    .clipped()
                
                Picker(selection: self.$count, label: Text("")) {
                    ForEach(0..<self.counts.count, id: \.self) { index in
                        Text("\(self.counts[index])").tag(index)
                    }
                }
                    .pickerStyle(.wheel)
                    .frame(width: geometry.size.width/2, height: geometry.size.height, alignment: .center)
                    .compositingGroup()
                    .clipped()
            }
        }
    }
}
