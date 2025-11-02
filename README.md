# 綠生活・綠色商店資料解析程式

## 專案說明
本專案為 **.NET 9.0 的 C# 主控台應用程式**，
主要用於讀取並解析政府開放資料集「綠生活_綠色商店」JSON 檔案。
程式會透過 `Newtonsoft.Json` 解析資料內容，
並在主控台輸出商店資訊（包含行政代碼、項次、縣市別、商店名稱、地址、電話等）。

---

## 程式功能
* **讀取 JSON 檔案**：從 `Data/greenStoreJson.json` 讀取資料
* **資料模型 `GreenStoreEntry`**：對應 JSON 欄位（行政代碼、項次、縣市別代碼、綠色商店名稱、聯絡地址、連絡電話）
* **資料排序**：依項次升冪排序，再依行政代碼排序
* **資料分組**：依行政代碼分組（示範用）
* **顯示前 10 筆**：避免輸出過多資料，僅顯示前 10 筆
* **自訂 JSON 轉換器**：處理項次欄位可能為字串或數字的情況

---

## 資料來源
| 資料集名稱       | 提供單位        | 授權與來源           |
| ----------- | ----------- | --------------- |
| 綠生活－綠色商店資料集 | 政府開放資料（環境部） | 依政府開放資料平台授權條款使用 |

專案已內含範例檔案：
`Data/greenStoreJson.json`
可直接執行測試。

---

## 開發環境需求
* .NET 9.0 SDK（或相容版本）
* Windows PowerShell 或 Visual Studio 2022
* **Newtonsoft.Json 套件**（必要）

安裝套件：
```bash
Install-Package Newtonsoft.Json
```

或使用 .NET CLI：
```bash
dotnet add package Newtonsoft.Json
```

---

## 建置與執行方式
在專案根目錄執行以下指令：
```powershell
# 建置（Release 組態）
dotnet build -c Release

# 直接執行
dotnet run -c Release

# 或執行已編譯的可執行檔
dotnet run
```

執行後會於主控台輸出前 10 筆商店資料，
包含行政代碼、項次、縣市別代碼、商店名稱、地址與聯絡電話等資訊。

---

## 專案結構
```
GreenStoreParser/
├─ Program.cs              # 主程式（包含 GreenStoreEntry 類別）
├─ Data/
│  └─ greenStoreJson.json  # 綠色商店 JSON 資料檔
└─ README.md
```

---

## 輸出範例
```
嘗試讀取檔案: C:\...\Data\greenStoreJson.json
成功反序列化 XXX 筆資料。

顯示前 10 筆資料：

第 1 筆資料：
  行政代碼：XXXXXXX
  項次：1
  縣市別代碼：XX
  綠色商店名稱：XXXXX
  聯絡地址：XXXXX
  聯絡電話：XXXXX
----------------------------------------
...
```

## 授權
此專案程式碼之授權依本儲存庫之 `LICENSE` 檔案為準。
若未提供，則預設僅供學習與示範使用。

資料集著作權及使用規範依政府開放資料平台之授權條款執行。
