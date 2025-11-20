//
//  HomeView.swift
//  GreenStore
//
//  Created by 王耀偉 on 2025/11/9.
//

import SwiftUI
import MapKit // longtitude:經度 latitude:緯度

struct GreenStore: Identifiable {
    let id = UUID()
    let name: String
    let phone: String
    let address: String
    let coordinate: CLLocationCoordinate2D
}

struct HomeView: View {
    
    // 以台中市政府為中心 latitude: 24.16167, longitude: 120.64684
    let cameraPosition: MapCameraPosition = .region(.init(center: .init(latitude: 24.16167, longitude: 120.64684), latitudinalMeters: 13000, longitudinalMeters: 13000))
    
    // 取得使用者所在位置
    let locationManager = CLLocationManager()
    
    // 環視圖
    @State private var lookAroundScene: MKLookAroundScene?
    
    @State private var isShowingLookAround = false
    
    // 模擬使用者所在位置，現在 true 是為了模擬，但當要使用真正的位置再改成 false
    @State private var useSimulatedLocation = true
    
    let simulatedUserLocation = CLLocationCoordinate2D(latitude: 24.16167, longitude: 120.64684)
    
    @State private var route: MKRoute?
    
    // 選擇哪個商店
    @State private var selectedStore: GreenStore?
    
    // 儲存喜歡的商店 ID
    @State private var likedStoreIDs: Set<UUID> = []
    
    let stores = [
        GreenStore(name: "7-11第一廣場門市", phone: "02-27478711", address: "400台中市中區中正路36號", coordinate: .greenStore1),
        GreenStore(name: "7-11鑫華新門市", phone: "02-27478711", address: "400台中市中區中華里中華路一段75.77號;民族路218號", coordinate: .greenStore2),
        GreenStore(name: "7-11錦花門市", phone: "02-27478711", address: "400台中市中區光復路127號", coordinate: .greenStore3)
    ]
    
    var body: some View {
        Map(initialPosition: cameraPosition) {
            
            ForEach(stores) { store in
                Annotation(store.name, coordinate: store.coordinate, anchor: .center) {
                    ZStack {
                        Button {
                            Task {
                                lookAroundScene = await getLookAroundScene(from: store.coordinate)
                                selectedStore = store
                            }
                        } label: {
                            Image(systemName: "leaf.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(.white)
                                .frame(width: 20, height: 20)
                                .padding(7)
                                .background(likedStoreIDs.contains(store.id) ? .pink : .green, in: .circle)
                        }
                        
                        if likedStoreIDs.contains(store.id) {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.pink)
                                .font(.system(size: 16))
                                .background(
                                    Image(systemName: "heart.fill")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 20))
                                )
                                .offset(x: 11, y: 12)
                                .transition(.scale.combined(with: .opacity))
                        }
                    }
                    .animation(.spring(response: 0.4, dampingFraction: 0.6), value: likedStoreIDs)
                }
            }
            
            // 模擬使用者所在的位置，否則用使用者的真實位置
            if useSimulatedLocation {
                Annotation("我的位置", coordinate: simulatedUserLocation) {
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
            
            if let route {
                MapPolyline(route)
                    .stroke(Color.green, lineWidth: 4)
            }
            
        }
        .mapStyle(.standard(pointsOfInterest: .excludingAll))
        .preferredColorScheme(.dark)
        .lookAroundViewer(isPresented: $isShowingLookAround, initialScene: lookAroundScene)
        .sheet(item: $selectedStore) { store in
            StoreDetailSheet(store: store,
                             lookAroundScene: lookAroundScene,
                             onGetDirections: { destination in
                                         getDirections(to: destination)
                                         selectedStore = nil // 關閉 sheet
                                     },
                             isLiked: likedStoreIDs.contains(store.id),
                             onToggleLike: {
                                 if likedStoreIDs.contains(store.id) {
                                     likedStoreIDs.remove(store.id)
                                 } else {
                                     likedStoreIDs.insert(store.id)
                                 }
                             })
                .presentationDetents([.height(520)])
                .presentationDragIndicator(.visible)
        }
        .onAppear {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // 環視圖 Function
    func getLookAroundScene(from coordinate: CLLocationCoordinate2D) async -> MKLookAroundScene? {
        do {
            return try await MKLookAroundSceneRequest(coordinate: coordinate).scene
        } catch {
            print("Cannot retrieve Look Around scenes: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getUserLocation() async -> CLLocationCoordinate2D? {
        let updates = CLLocationUpdate.liveUpdates()
        
        do {
            let update = try await updates.first { $0.location?.coordinate != nil}
            return update?.location?.coordinate
        } catch {
            print("Cannot get user location")
            return nil
        }
    }
    
    func getDirections(to destination: CLLocationCoordinate2D) {
        Task {
            
            let userLocation = useSimulatedLocation ? simulatedUserLocation : await getUserLocation()
            
            guard let userLocation = userLocation else { return }
            
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: .init(coordinate: userLocation))
            request.destination = MKMapItem(placemark: .init(coordinate: destination))
            
            // 走路：.walking 開車：.automobile 大眾運輸：.transit 任意（讓系統自動選擇）：.any（系統會根據距離自動選擇最適合的方式）
            request.transportType = .any
            
            do {
                let directions = try await MKDirections(request: request).calculate()
                route = directions.routes.first
            } catch {
               print("Show error")
            }
        }
    }
}

#Preview {
    HomeView()
}

// 測資的經緯度
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
