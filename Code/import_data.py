import json
import re
from models import GreenStore, SessionLocal, init_db

def extract_city(address):
    """從地址提取縣市名稱"""
    cities = [
        "台北市", "新北市", "桃園市", "台中市", "台南市", "高雄市",
        "基隆市", "新竹市", "嘉義市",
        "新竹縣", "苗栗縣", "彰化縣", "南投縣", "雲林縣", "嘉義縣",
        "屏東縣", "宜蘭縣", "花蓮縣", "台東縣", "澎湖縣", "金門縣", "連江縣"
    ]
    for city in cities:
        if city in address:
            return city
    return None

def import_stores_from_json(json_file_path):
    """從 JSON 檔案匯入商店資料"""
    
    # 先初始化資料庫
    init_db()
    
    # 讀取 JSON 檔案
    with open(json_file_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    db = SessionLocal()
    
    try:
        # 清空舊資料（可選）
        db.query(GreenStore).delete()
        db.commit()
        
        success_count = 0
        error_count = 0
        
        # 匯入每筆資料
        for item in data:
            try:
                address = item.get('聯絡地址', '')
                
                store = GreenStore(
                    admin_code=item.get('行政代碼', ''),
                    item_no=item.get('項次', ''),
                    city_code=item.get('縣市別代碼', ''),
                    store_name=item.get('綠色商店名稱', ''),
                    address=address,
                    phone=item.get('連絡電話', ''),
                    city=extract_city(address)
                )
                
                db.add(store)
                success_count += 1
                
            except Exception as e:
                print(f"匯入失敗: {item.get('綠色商店名稱', 'Unknown')} - {e}")
                error_count += 1
        
        # 提交所有變更
        db.commit()
        
        print(f"\n{'='*50}")
        print(f"匯入完成！")
        print(f"成功: {success_count} 筆")
        print(f"失敗: {error_count} 筆")
        print(f"{'='*50}\n")
        
        # 顯示一些統計資訊
        total = db.query(GreenStore).count()
        print(f"資料庫總筆數: {total}")
        
        # 顯示各縣市商店數量
        cities = db.query(GreenStore.city).distinct().all()
        print(f"\n各縣市商店分布:")
        for (city,) in cities:
            if city:
                count = db.query(GreenStore).filter(GreenStore.city == city).count()
                print(f"  {city}: {count} 家")
        
    except Exception as e:
        print(f"匯入過程發生錯誤: {e}")
        db.rollback()
    finally:
        db.close()

if __name__ == "__main__":
    # 使用方式：把你的 JSON 檔案路徑放這裡
    import_stores_from_json('green_store.json')