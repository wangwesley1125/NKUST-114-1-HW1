//
//  HomeView.swift
//  GreenStore
//
//  Created by 王耀偉 on 2025/11/9.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    let locationManager = CLLocationManager()
    
    var body: some View {
        Map() {
            UserAnnotation()
        }
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
}

#Preview {
    HomeView()
}
