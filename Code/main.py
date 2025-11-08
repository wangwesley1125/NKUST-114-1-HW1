from fastapi import FastAPI, Query, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from models import GreenStore, SessionLocal
from typing import Optional, List
from pydantic import BaseModel

app = FastAPI(
    title="綠色商店 API",
    description="提供台灣綠色商店資料查詢服務",
    version="1.0.0"
)

# 允許跨域請求（讓 iOS App 可以存取）
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Pydantic 模型（回傳格式）
class StoreResponse(BaseModel):
    id: int
    admin_code: str
    item_no: str
    city_code: str
    store_name: str
    address: str
    phone: str
    latitude: Optional[float]
    longitude: Optional[float]
    city: Optional[str]
    
    class Config:
        from_attributes = True

@app.get("/")
def root():
    """API 首頁"""
    return {
        "message": "歡迎使用綠色商店 API",
        "docs": "/docs",
        "endpoints": {
            "all_stores": "/api/stores",
            "store_by_id": "/api/stores/{id}",
            "cities": "/api/cities"
        }
    }

@app.get("/api/stores", response_model=List[StoreResponse])
def get_stores(
    city: Optional[str] = Query(None, description="縣市名稱，例如：台中市"),
    search: Optional[str] = Query(None, description="搜尋商店名稱"),
    limit: int = Query(1000, ge=1, le=1000, description="回傳筆數上限"),
    offset: int = Query(0, ge=0, description="略過筆數（分頁用）")
):
    """
    取得綠色商店列表
    
    - **city**: 依縣市篩選
    - **search**: 搜尋商店名稱（模糊比對）
    - **limit**: 最多回傳幾筆（預設 50）
    - **offset**: 從第幾筆開始（分頁用）
    """
    db = SessionLocal()
    
    try:
        query = db.query(GreenStore)
        
        # 依縣市篩選
        if city:
            query = query.filter(GreenStore.city == city)
        
        # 搜尋商店名稱
        if search:
            query = query.filter(GreenStore.store_name.like(f"%{search}%"))
        
        # 分頁
        stores = query.offset(offset).limit(limit).all()
        
        return stores
    
    finally:
        db.close()

@app.get("/api/stores/{store_id}", response_model=StoreResponse)
def get_store_by_id(store_id: int):
    """取得單一商店詳細資料"""
    db = SessionLocal()
    
    try:
        store = db.query(GreenStore).filter(GreenStore.id == store_id).first()
        
        if not store:
            raise HTTPException(status_code=404, detail="找不到此商店")
        
        return store
    
    finally:
        db.close()

@app.get("/api/cities")
def get_cities():
    """取得所有縣市列表及各縣市商店數量"""
    db = SessionLocal()
    
    try:
        # 查詢所有縣市及數量
        cities_data = db.query(
            GreenStore.city,
            db.func.count(GreenStore.id).label('count')
        ).group_by(GreenStore.city).all()
        
        result = [
            {"city": city, "store_count": count}
            for city, count in cities_data
            if city is not None
        ]
        
        # 依商店數量排序
        result.sort(key=lambda x: x['store_count'], reverse=True)
        
        return {
            "total_cities": len(result),
            "cities": result
        }
    
    finally:
        db.close()

@app.get("/api/stats")
def get_statistics():
    """取得統計資訊"""
    db = SessionLocal()
    
    try:
        total_stores = db.query(GreenStore).count()
        total_cities = db.query(GreenStore.city).distinct().count()
        
        return {
            "total_stores": total_stores,
            "total_cities": total_cities,
            "database": "green_stores.db"
        }
    
    finally:
        db.close()

# 啟動方式：
# python3 -m uvicorn main:app --reload
# 然後開啟瀏覽器到 http://127.0.0.1:8000/docs