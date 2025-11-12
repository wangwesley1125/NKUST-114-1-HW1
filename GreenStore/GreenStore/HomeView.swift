//
//  HomeView.swift
//  GreenStore
//
//  Created by 王耀偉 on 2025/11/9.
//

import SwiftUI
import MapKit

struct HomeView: View {
    // 以台中市政府為中心
    @State private var cameraPosition: MapCameraPosition = .region(
        .init(center: .init(latitude: 24.16304671963227,
                            longitude: 120.64669143694526),
              latitudinalMeters: 1300,
              longitudinalMeters: 1300)
    )
    
    let locationManager = CLLocationManager()
    
    var body: some View {
        Map(position: $cameraPosition) {
            UserAnnotation()
        }
//        .onAppear {
//            locationManager.requestWhenInUseAuthorization()
//        }
//        .mapControls {
//            MapUserLocationButton()
//            MapCompass()
//            MapPitchToggle()
//            MapScaleView()
//        }
    }
    
}

#Preview {
    HomeView()
}
