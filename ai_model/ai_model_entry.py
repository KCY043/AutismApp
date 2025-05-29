from fastapi import FastAPI
from transformers import pipeline

app = FastAPI()
classifier = pipeline("sentiment-analysis")

@app.post("/ai/chat")
async def ai_chat(request: dict):
    content = request.get("content")
    if not content:
        return {"error": "No content provided"}
    result = classifier(content)
    return {"response": result[0]['label'], "score": result[0]['score']}