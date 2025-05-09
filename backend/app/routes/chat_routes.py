@router.post("/chat")
async def chat_response(message: ChatMessage):
    reply = some_ai_logic(message.content)
    return {"response": reply}