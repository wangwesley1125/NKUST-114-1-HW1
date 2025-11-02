using System;
using System.IO;
using System.Linq;
using System.Collections.Generic;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq; // 解析 JSON 用的套件

class Program
{
    static void Main()
    {
        // 取得 JSON 檔案路徑
        string filePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Data", "greenStoreJson.json");

        Console.WriteLine($"嘗試讀取檔案: {filePath}");

        if (!File.Exists(filePath))
        {
            Console.WriteLine("錯誤：找不到檔案，請確認路徑是否正確！");
            Console.ReadLine();
            return;
        }

        try
        {
            // 讀取 JSON
            string jsonContent = File.ReadAllText(filePath).Trim();
            if (string.IsNullOrEmpty(jsonContent))
            {
                Console.WriteLine("JSON 檔案為空。");
                Console.ReadLine();
                return;
            }

            // 反序列化為型別清單（對應中文欄位）
            var list = JsonConvert.DeserializeObject<List<GreenStoreEntry>>(jsonContent);

            if (list == null)
            {
                Console.WriteLine("反序列化失敗：資料為 null");
                Console.ReadLine();
                return;
            }

            Console.WriteLine($"成功反序列化 {list.Count} 筆資料。");

            // 排序（依照項次升冪，若無項次則放最後）
            var ordered = list
                .OrderBy(x => x.ItemNo ?? int.MaxValue)
                .ThenBy(x => x.AdministrativeCode ?? string.Empty)
                .ToList();

            // 分組示範（依行政代碼）
            var groups = ordered.GroupBy(x => x.AdministrativeCode ?? "UNKNOWN").ToList();

            // 顯示前 10 筆（避免輸出過多）
            int displayCount = Math.Min(10, ordered.Count);
            Console.WriteLine($"\n顯示前 {displayCount} 筆資料：\n");

            for (int i = 0; i < displayCount; i++)
            {
                var e = ordered[i];
                Console.WriteLine($"第 {i + 1} 筆資料：");
                Console.WriteLine($"  行政代碼：{e.AdministrativeCode}");
                Console.WriteLine($"  項次：{(e.ItemNo.HasValue ? e.ItemNo.Value.ToString() : "(null)")}") ;
                Console.WriteLine($"  縣市別代碼：{e.CountyCode}");
                Console.WriteLine($"  綠色商店名稱：{e.StoreName}");
                Console.WriteLine($"  聯絡地址：{e.Address}");
                Console.WriteLine($"  聯絡電話：{e.Phone}");
                Console.WriteLine(new string('-', 40));
            }

            if (ordered.Count > displayCount)
            {
                Console.WriteLine($"... 還有 {ordered.Count - displayCount} 筆資料未顯示");
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

// 型別對應到 JSON 的欄位
public class GreenStoreEntry
{
    [JsonProperty("行政代碼")]
    public string AdministrativeCode { get; set; }

    [JsonProperty("項次")]
    [JsonConverter(typeof(ItemNoConverter))]
    public int? ItemNo { get; set; }

    [JsonProperty("縣市別代碼")]
    public string CountyCode { get; set; }

    [JsonProperty("綠色商店名稱")]
    public string StoreName { get; set; }

    [JsonProperty("聯絡地址")]
    public string Address { get; set; }

    [JsonProperty("連絡電話")]
    public string Phone { get; set; }
}

// 自訂 converter：允許項次為字串或數字，並安全轉換
public class ItemNoConverter : JsonConverter
{
    public override bool CanConvert(Type objectType)
    {
        return objectType == typeof(int?) || objectType == typeof(int);
    }

    public override object ReadJson(JsonReader reader, Type objectType, object existingValue, JsonSerializer serializer)
    {
        if (reader.TokenType == JsonToken.Null)
            return null;

        if (reader.TokenType == JsonToken.Integer)
            return Convert.ToInt32(reader.Value);

        if (reader.TokenType == JsonToken.String)
        {
            var s = (string)reader.Value;
            if (int.TryParse(s, out int v))
                return v;
            return null;
        }

        // 其他型別保守返回 null
        return null;
    }

    public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
    {
        if (value == null)
            writer.WriteNull();
        else
            writer.WriteValue((int)value);
    }
}
