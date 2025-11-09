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
            Tab("首頁", systemImage: "map.fill") {
                HomeView()
            }
            
            Tab("收藏", systemImage: "star.fill") {
                LikeView()
            }
            
            Tab("API測試", systemImage: "network") {
                ConnectApiView()
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
