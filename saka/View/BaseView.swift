//
//  BaseView.swift
//  saka
//
//  Created by Takahiro Tominaga on 2022/01/22.
//

import SwiftUI

struct BaseView: View {
    
    // Using Image Names as Tab...
    @State var currentTab = "house"
    
    var colorBG = Color.green.opacity(0.1)
    
    // Hiding Native One..
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            // Tab View..
            TabView(selection: $currentTab) {
                
                MemberListView()
                    .tag("house")
                
                Text("Blog")
                    .tag("text.justify.left")
                
                Text("Formation")
                    .tag("circle.hexagonpath")
                
                Text("Quiz")
                    .tag("checkmark.square")
                
                Text("Settings")
                    .tag("gearshape.fill")
            }
            
            // Custom Tab Bar...
            HStack(spacing: 40) {
                
                // Tab Buttons...
                TabButton(image: "house")
                TabButton(image: "text.justify.left")
                TabButton(image: "circle.hexagonpath")
                TabButton(image: "checkmark.square")
                TabButton(image: "gearshape.fill")
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    @ViewBuilder
    func TabButton(image: String) -> some View {
        
        Button {
            withAnimation {
                currentTab = image
            }
        } label: {
            Image(systemName: image)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(
                
                    currentTab == image ? Color.black : Color.gray.opacity(0.8)
                )
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
