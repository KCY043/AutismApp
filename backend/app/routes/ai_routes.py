from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from loguru import logger
from backend.app.services.ai_service import generate_ai_reply
from backend.app.database import get_db_session
from backend.app.models import ChatLog

router = APIRouter()

class ChatRequest(BaseModel):
    content: str
    user_id: int  # 加入 user_id 以便儲存對話

@router.post("/ai/chat")
async def ai_chat(request: ChatRequest):
    logger.info(f"Received message from user {request.user_id}: {request.content}")

    try:
        # 調用 AI 生成回覆
        ai_reply = generate_ai_reply(request.content)

        # 儲存對話到資料庫
        session = next(get_db_session())
        new_log = ChatLog(
            user_id=request.user_id,
            message=request.content,
            sender="user"
        )
        session.add(new_log)
        session.commit()

        reply_log = ChatLog(
            user_id=request.user_id,
            message=ai_reply,
            sender="ai"
        )
        session.add(reply_log)
        session.commit()

        return {"response": ai_reply}

    except Exception as e:
        logger.error(f"Error in /ai/chat: {e}")
        raise HTTPException(status_code=500, detail="AI服務發生錯誤")
