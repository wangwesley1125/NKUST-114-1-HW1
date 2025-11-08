from sqlalchemy import Column, Integer, String, Float, create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

Base = declarative_base()

class GreenStore(Base):
    __tablename__ = "green_stores"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    admin_code = Column(String, index=True)  # 行政代碼
    item_no = Column(String)  # 項次
    city_code = Column(String, index=True)  # 縣市別代碼
    store_name = Column(String, index=True)  # 綠色商店名稱
    address = Column(String)  # 聯絡地址
    phone = Column(String)  # 連絡電話
    
    # 額外欄位（之後可擴充）
    latitude = Column(Float, nullable=True)  # 緯度
    longitude = Column(Float, nullable=True)  # 經度
    city = Column(String, index=True, nullable=True)  # 縣市（從地址解析）
    
    def to_dict(self):
        return {
            "id": self.id,
            "admin_code": self.admin_code,
            "item_no": self.item_no,
            "city_code": self.city_code,
            "store_name": self.store_name,
            "address": self.address,
            "phone": self.phone,
            "latitude": self.latitude,
            "longitude": self.longitude,
            "city": self.city
        }

# 建立資料庫引擎
engine = create_engine('sqlite:///green_stores.db', echo=True)
SessionLocal = sessionmaker(bind=engine)

# 建立資料表
def init_db():
    Base.metadata.create_all(engine)
    print("資料庫表格建立完成！")

if __name__ == "__main__":
    init_db()