//
//  LikeView.swift
//  GreenStore
//
//  Created by 王耀偉 on 2025/11/9.
//

import SwiftUI


struct LikeView: View {
    
    @Binding var likedStoreIDs: Set<Int>
    
//    let stores = [
//        GreenStore(id: 1, name: "7-11第一廣場門市", phone: "02-27478711", address: "400台中市中區中正路36號", coordinate: .greenStore1),
//        GreenStore(id: 2, name: "7-11鑫華新門市", phone: "02-27478711", address: "400台中市中區中華里中華路一段75.77號;民族路218號", coordinate: .greenStore2),
//        GreenStore(id: 3, name: "7-11錦花門市", phone: "02-27478711", address: "400台中市中區光復路127號", coordinate: .greenStore3)
//    ]
    
    // 從 API 取得的商店資料
    @State private var stores = [GreenStore]()
    
    var likedStores: [GreenStore] {
        stores.filter { likedStoreIDs.contains($0.id) }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if likedStores.isEmpty {
                    VStack {
                        Text("目前沒收藏商店")
                            .foregroundColor(.gray)
                            .font(.title)
                    }
                } else {
                    List {
                        ForEach(likedStores) { store in
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Image(systemName: "storefront.fill")
                                            .foregroundStyle(.green)
                                        Text(store.name)
                                            .font(.headline)
                                    }
                                    
                                    HStack {
                                        Image(systemName: "phone.fill")
                                            .foregroundStyle(.green)
                                            .font(.caption)
                                        Text(store.phone)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                    
                                    HStack(alignment: .top) {
                                        Image(systemName: "mappin.and.ellipse")
                                            .foregroundStyle(.green)
                                            .font(.caption)
                                        Text(store.address)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                            .lineLimit(2)
                                    }
                                }
                                
                                Spacer()
                                
                                Button {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        _ = likedStoreIDs.remove(store.id)
                                    }
                                } label: {
                                    Image(systemName: "heart.fill")
                                        .foregroundStyle(.pink)
                                        .font(.title2)
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                likedStoreIDs.remove(likedStores[index].id)
                            }
                        }
                    }
                }
            }
            .navigationTitle("收藏")
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
            if let decodedResponse = try? JSONDecoder().decode([GreenStore].self, from: data) {
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
    LikeView(likedStoreIDs: .constant([]))
}
