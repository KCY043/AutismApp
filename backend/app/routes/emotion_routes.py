from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from app.database import get_db_session
from app.models import ChatLog
from app.services.emotion_service import analyze_emotion_summary

router = APIRouter()

@router.get("/chat/emotion-summary/{user_id}")
async def get_emotion_summary(user_id: int, db: Session = Depends(get_db_session)):
    logs = db.query(ChatLog).filter(ChatLog.user_id == user_id).all()
    if not logs:
        raise HTTPException(status_code=404, detail="No chat logs found for this user.")

    summary = analyze_emotion_summary(logs)
    return summary
