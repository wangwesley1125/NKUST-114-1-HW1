//
//  StoreDetailSheet.swift
//  GreenStore
//
//  Created by 王耀偉 on 2025/11/14.
//

import SwiftUI
import MapKit

struct StoreDetailSheet: View {
    
    let store: GreenStore
    
    let lookAroundScene: MKLookAroundScene?
    
    let onGetDirections: (CLLocationCoordinate2D) -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(store.name)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                HStack {
                    Image(systemName: "phone.fill")
                        .foregroundStyle(.green)
                    Text(store.phone)
                }
                
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundStyle(.green)
                    Text(store.address)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            // 環視圖
            if let scene = lookAroundScene {
                LookAroundPreview(initialScene: scene)
                    .frame(height: 300)
                    .cornerRadius(12)
                    .padding(.horizontal)
            } else {
                // 當沒有 Look Around 資料時顯示
                VStack {
                    Image(systemName: "eye.slash")
                        .font(.largeTitle)
                        .foregroundStyle(.gray)
                    Text("此地點無環視圖")
                        .foregroundStyle(.secondary)
                }
                .frame(height: 200)
                .frame(maxWidth: .infinity)
            }
            
            // 取得路線按鈕
            Button {
                onGetDirections(store.coordinate)
            } label: {
                HStack {
                    Image(systemName: "arrow.triangle.turn.up.right.circle.fill")
                    Text("取得路線")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.green)
                .foregroundStyle(.white)
                .cornerRadius(12)
            }
            .padding()
        }
        
    }
    
}

#Preview {
    StoreDetailSheet(store: GreenStore(
        name: "7-11第一廣場門市",
        phone: "04-2222-3333",
        address: "台中市中區綠川西街135號",
        coordinate: .greenStore1
    ), lookAroundScene: nil, onGetDirections: { _ in }
    )
}
