from fastapi import FastAPI
from app.routes import ai_routes  # 修改這裡
from app.database import engine, Base
from app.routes import ai_routes

app = FastAPI()
Base.metadata.create_all(bind=engine)
app.include_router(ai_routes.router)