//
//  HomeView.swift
//  GreenStore
//
//  Created by 王耀偉 on 2025/11/9.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    let cameraPosition: MapCameraPosition = .region(.init(center: .init(latitude: 22.654523735389255, longitude: 120.32997267412121), latitudinalMeters: 130, longitudinalMeters: 130))
    
    let locationManager = CLLocationManager()
    
    var body: some View {
        Map(initialPosition: cameraPosition) {
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
