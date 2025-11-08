## 專案說明
本專案為 SwiftUI 開發的 iOS App，
用於讀取並解析政府開放資料集「綠生活_綠色商店」JSON 檔案，
並將綠色商店 以地圖標記（Map Annotation）方式顯示其所在位置。

App 採用 Swift 的 Codable 機制進行 JSON 解碼，
並結合 MapKit（或 SwiftUI Map）將商店位置呈現在互動地圖上，
使用者可以縮放、平移地圖，並點擊標記查看商店詳細資訊（行政代碼、項次、縣市別、商店名稱、地址、電話等）。

此外，App 支援資料篩選、排序與基本錯誤處理，展示政府開放資料在行動端的應用情境。

## Demo（目前進度）
<div align="center">
  <img src="Docs/demo.gif" width="300" alt="綠生活・綠色商店 App Demo">
</div>

## 授權
此專案程式碼之授權依本儲存庫之 `LICENSE` 檔案為準。
若未提供，則預設僅供學習與示範使用。

資料集著作權及使用規範依政府開放資料平台之授權條款執行。
