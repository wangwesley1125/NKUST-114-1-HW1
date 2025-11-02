using System;
using System.IO;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq; // 解析 JSON 用的套件

class Program
{
    static void Main()
    {
        // 取得 JSON 檔案路徑
        string filePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Data", "greenStoreJson.json");

        // 檢查檔案是否存在
        if (!File.Exists(filePath))
        {
            Console.WriteLine("找不到檔案，請確認路徑是否正確！");
            Console.WriteLine($"期待位置: {filePath}");
            Console.ReadLine();
            return;
        }

        try
        {
            // 讀取整個 JSON 內容
            string jsonContent = File.ReadAllText(filePath).Trim();
            if (string.IsNullOrEmpty(jsonContent))
            {
                Console.WriteLine("JSON 檔案為空。");
                Console.ReadLine();
                return;
            }

            // 解析 JSON（能處理陣列或物件）
            JToken token = JToken.Parse(jsonContent);

            if (token is JArray jsonArray)
            {
                Console.WriteLine($"JSON 為陣列，共 {jsonArray.Count} 筆資料：");
                foreach (var item in jsonArray)
                {
                    Console.WriteLine(item.ToString(Formatting.Indented)); // 美化輸出
                    Console.WriteLine("----------------------------");
                }
            }
            else if (token is JObject jsonObject)
            {
                Console.WriteLine("JSON 為物件：");
                Console.WriteLine(jsonObject.ToString(Formatting.Indented));
            }
            else
            {
                // 其他類型（例如字串、數字）
                Console.WriteLine("JSON 為其他類型：");
                Console.WriteLine(token.ToString(Formatting.Indented));
            }
        }
        catch (JsonReaderException jex)
        {
            Console.WriteLine("解析 JSON 發生錯誤：");
            Console.WriteLine(jex.Message);
        }
        catch (Exception ex)
        {
            Console.WriteLine("讀取或處理檔案時發生錯誤：");
            Console.WriteLine(ex.Message);
        }

        Console.WriteLine("完成！");
        Console.ReadLine();
    }
}
