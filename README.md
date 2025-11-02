# 綠生活・綠色商店資料解析程式

## 專案說明

本專案為 **.NET 9.0 的 C# 主控台應用程式**，
主要用於讀取並解析政府開放資料集「綠生活_綠色商店_1130531.csv.json」。

程式會透過 `System.Text.Json` 或 `Newtonsoft.Json` 解析資料內容，
並在主控台輸出商店資訊（例如店名、地址、負責單位、縣市等）。

---

## 程式重點

* **資料模型 `GreenStoreInfo`** 對應 JSON 欄位：
  （機構名稱、商店名稱、電話、地址、縣市、區域、分類、登錄日期等）
---

## 資料來源

| 資料集名稱       | 提供單位        | 授權與來源           |
| ----------- | ----------- | --------------- |
| 綠生活－綠色商店資料集 | 政府開放資料（環境部） | 依政府開放資料平台授權條款使用 |

專案已內含範例檔案：
`Data/綠生活_綠色商店_1130531.csv.json`
可直接執行測試。

---

## 開發環境需求

* .NET 9.0 SDK（或相容版本）
* Windows PowerShell 或 Visual Studio 2022
* Newtonsoft.Json 套件（若使用 Newtonsoft）

```bash
Install-Package Newtonsoft.Json
```

---

## 建置與執行方式

在專案根目錄執行以下指令：

```powershell
# 建置（Release 組態）
dotnet build "ConsoleApp/ConsoleApp.csproj" -c Release

# 直接執行
dotnet run --project "ConsoleApp" -c Release

# 或執行已編譯的可執行檔
& "ConsoleApp/bin/Release/net9.0/ConsoleApp.exe"
```

執行後會於主控台輸出部分商店資料（例如前 10 筆），
包含縣市、商店名稱、地址與聯絡電話等資訊。

---

## 專案結構

```
GreenStoreParser/
├─ ConsoleApp/
│  ├─ ConsoleApp.csproj
│  ├─ Program.cs
│  ├─ GreenStoreInfo.cs
│  └─ Data/
│     └─ 綠生活_綠色商店_1130531.csv.json
└─ README.md
```

## 授權

此專案程式碼之授權依本儲存庫之 `LICENSE` 檔案為準。
若未提供，則預設僅供課程作業示範使用。
資料集著作權及使用規範依政府開放資料平台之授權條款執行。
