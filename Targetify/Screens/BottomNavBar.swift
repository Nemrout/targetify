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
            BottomNavBarButton(title: "Dashboard", icon: "chart.pie.fill") {
                page = .dashboard
            }
            
            BottomNavBarButton(title: "A/B Testing", icon: "atom") {
                page = .testing
            }
            
            BottomNavBarButton(title: "News feed", icon: "newspaper.fill") {
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
//            .previewLayout(.device)
    }
}

fileprivate struct BottomNavBarButton: View {
    
    let title: String
    
    let icon: String
    
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
            .foregroundColor(.white)
            .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity)
    }
}
