from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from app.services.local_gpt_service import generate_local_gpt_reply
from app.services.emotion_service import analyze_sentiment
from app.database import get_db_session
from app.models import ChatLog
from sqlalchemy.orm import Session

router = APIRouter()

class ChatRequest(BaseModel):
    content: str
    user_id: int

@router.post("/ai/chat")
async def ai_chat(request: ChatRequest):
    try:
        reply = generate_local_gpt_reply(request.content)
        sentiment = analyze_sentiment(request.content)

        session = next(get_db_session())
        session.add(ChatLog(user_id=request.user_id, message=request.content, sender='user', sentiment=sentiment))
        session.add(ChatLog(user_id=request.user_id, message=reply, sender='ai', sentiment=sentiment))
        session.commit()

        return {"response": reply, "sentiment": sentiment}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"AI服務錯誤: {e}")
