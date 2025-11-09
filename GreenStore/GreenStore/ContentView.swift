//
//  ContentView.swift
//  GreenStore
//
//  Created by Wesley on 2025/11/8.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            Tab("首頁", systemImage: "house.fill") {
                HomeView()
            }
            
            Tab("收藏", systemImage: "star.fill") {
                LikeView()
            }
            
            Tab("設定", systemImage: "gear") {
                SettingView()
            }
        }
    }
    
}

#Preview {
    ContentView()
}
