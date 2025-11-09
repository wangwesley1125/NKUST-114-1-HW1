//
//  ContentView.swift
//  GreenStore
//
//  Created by Wesley on 2025/11/8.
//

import SwiftUI

struct Store: Codable, Identifiable {
    var id: Int
    var admin_code: String?
    var item_no: String?
    var city_code: String?
    var store_name: String?
    var address: String?
    var phone: String?
    var latitude: Double?
    var longitude: Double?
    var city: String?
}

struct ContentView: View {
    
    @State private var stores = [Store]()
    
    var body: some View {
        NavigationStack {
            List(stores, id: \.id) { store in
                VStack(alignment: .leading) {
                    Text(store.store_name ?? "無店名")
                        .font(.headline)
                    Text(store.address ?? "無地址")
                        .font(.body)
                    Text(store.phone ?? "無電話")
                        .font(.body)
                    Text(store.city ?? "無城市")
                        .font(.body)
                }
            }
            .navigationTitle("綠色商店")
            .task {
                await fetchData()
            }
        }
    }
    
    func fetchData() async {
        // create url
        guard let url = URL(string: "http://127.0.0.1:8000/api/stores") else {
            print("Hey man This URL doesn't work")
            return
        }
        // fetch data from that url
        do { let(data, _) = try await URLSession.shared.data(from: url)
            // decode that data bruther
            if let decodedResponse = try? JSONDecoder().decode([Store].self, from: data) {
                stores = decodedResponse
            }else {
                print("Decoding failed: \(String(data: data, encoding: .utf8) ?? "no data")")
            }
        } catch {
            print("bad news ... this data isn't work :(")
        }
    }
}

#Preview {
    ContentView()
}
