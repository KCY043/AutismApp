from fastapi import FastAPI
from app.routes import ai_routes 
# 接回 DB 再開
# from app.routes import user_routes, chat_routes, emotion_routes

app = FastAPI(title="Autism App Backend")

# AI 相關
app.include_router(ai_routes.router, prefix="/ai", tags=["ai"])

# 接回 DB 再打開
# app.include_router(user_routes.router, prefix="/users", tags=["users"])
# app.include_router(chat_routes.router, prefix="/chat", tags=["chat"])
# app.include_router(emotion_routes.router, prefix="/emotion", tags=["emotion"])

@app.get("/healthz")
def healthz():
    return {"ok": True}
