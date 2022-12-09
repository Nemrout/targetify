//
//  BottomNavBar.swift
//  Targetify
//
//  Created by Петрос Тепоян on 11/25/22.
//

import SwiftUI

struct BottomNavBar: View {
    
    @Binding var page: BottomNavBarPage
    
    var body: some View {
        HStack {
            BottomNavBarButton(title: "Dashboard", icon: "chart.pie.fill", isSelected: page == .dashboard) {
                page = .dashboard
            }
            
            BottomNavBarButton(title: "A/B Testing", icon: "atom", isSelected: page == .testing) {
                page = .testing
            }
            
            BottomNavBarButton(title: "News", icon: "newspaper.fill", isSelected: page == .news) {
                page = .news
            }
        }
        .padding(.horizontal, 10)
        .frame(height: 60)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(TargetifyColors.primary)
                
        )
        
    }
}

enum BottomNavBarPage {
    case dashboard
    case testing
    case news
}

struct BottomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavBar(page: .constant(.dashboard))
            .previewLayout(.sizeThatFits)
            .previewDevice(nil)
    }
}

fileprivate struct BottomNavBarButton: View {
    
    let title: String
    
    let icon: String
    
    let isSelected: Bool
    
    let onTap: () -> ()
    
    var body: some View {
        Button {
            onTap()
        } label: {
            VStack(spacing: 0) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30, alignment: .center)
                
                Text(title)
            }
            .foregroundColor(isSelected ? .orange : .white)
            .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity)
    }
}
