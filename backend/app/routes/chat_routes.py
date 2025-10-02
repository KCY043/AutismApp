from fastapi import APIRouter, Depends
from pydantic import BaseModel
from sqlalchemy.orm import Session
from app.database import get_db_session
from app.models import ChatLog

router = APIRouter()

class ChatRequest(BaseModel):
    message: str
    user_id: int  # 如果有 user_id 需要，這邊加入

@router.post("/chat")
async def create_chat(request: ChatRequest, db: Session = Depends(get_db_session)):
    chat_log = ChatLog(message=request.message, user_id=request.user_id, sender="user")
    db.add(chat_log)
    db.commit()
    db.refresh(chat_log)
    return {"message": "Chat created successfully", "chat_log": chat_log.id}