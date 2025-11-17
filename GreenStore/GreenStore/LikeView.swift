//
//  LikeView.swift
//  GreenStore
//
//  Created by 王耀偉 on 2025/11/9.
//

import SwiftUI

struct LikeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("目前沒收藏商店")
                    .foregroundColor(.gray)
                    .font(.title)
            }
            
            .navigationTitle("收藏")
        }
        
    }
}

#Preview {
    LikeView()
}
