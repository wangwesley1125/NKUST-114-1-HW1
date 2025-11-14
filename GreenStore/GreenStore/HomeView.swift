//
//  HomeView.swift
//  GreenStore
//
//  Created by 王耀偉 on 2025/11/9.
//

import SwiftUI
import MapKit // longtitude:經度 latitude:緯度

struct HomeView: View {
    
    // 以台中市政府為中心 latitude: 24.16167, longitude: 120.64684
    let cameraPosition: MapCameraPosition = .region(.init(center: .init(latitude: 24.16167, longitude: 120.64684), latitudinalMeters: 13000, longitudinalMeters: 13000))
    
    let locationManager = CLLocationManager()
    
    @State private var useSimulatedLocation = true
    
    // Show Bottom Sheet
    @State private var showingBottomSheet = false
    
    var body: some View {
        Map(initialPosition: cameraPosition) {
            
            // 自定義 Marker
            Annotation("7-11第一廣場門市", coordinate: .greenStore1, anchor: .center) {
                Button {
                    showingBottomSheet.toggle()
                } label: {
                    Image(systemName: "leaf.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.white)
                        .frame(width: 20, height: 20)
                        .padding(7)
                        .background(.green.gradient, in: .circle)
                }
                .sheet(isPresented: $showingBottomSheet) {
                    StoreDetailSheet()
                        .presentationDetents([.height(200)])
                        .presentationDragIndicator(.visible)
                }
//                Image(systemName: "leaf.fill")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .foregroundStyle(.white)
//                    .frame(width: 20, height: 20)
//                    .padding(7)
//                    .background(.green.gradient, in: .circle)
            }
            
            Annotation("7-11鑫華新門市", coordinate: .greenStore2, anchor: .center) {
                Image(systemName: "leaf.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
                    .padding(7)
                    .background(.green.gradient, in: .circle)
            }
            
            Annotation("7-11錦花門市", coordinate: .greenStore3, anchor: .center) {
                Image(systemName: "leaf.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
                    .padding(7)
                    .background(.green.gradient, in: .circle)
            }
            
            // 模擬使用者所在的位置，否則用使用者的真實位置
            if useSimulatedLocation {
                Annotation("我的位置", coordinate: .init(latitude: 24.16167, longitude: 120.64684)) {
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.white)
                        .frame(width: 20, height: 20)
                        .padding(7)
                        .background(.blue.gradient, in: .circle)
                }
            } else {
                UserAnnotation()
            }
        }
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
}

#Preview {
    HomeView()
}

// 測資
extension CLLocationCoordinate2D {
    static let greenStore1 = CLLocationCoordinate2D(latitude: 24.2577969, longitude: 120.657518)
    static let greenStore2 = CLLocationCoordinate2D(latitude: 24.1438744, longitude: 120.6750245)
    static let greenStore3 = CLLocationCoordinate2D(latitude: 24.1427659, longitude: 120.6820957)
}


// Apple 原生 Marker
//            Marker("綠色商店 1", systemImage: "leaf.fill", coordinate: .greenStore1)
//                .tint(.green)
//Marker("綠色商店 2", systemImage: "leaf.fill", coordinate: .greenStore2)
//    .tint(.green)
//Marker("綠色商店 3", systemImage: "leaf.fill", coordinate: .greenStore3)
//    .tint(.green)
