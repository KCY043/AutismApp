import os
import google.generativeai as genai

GOOGLE_API_KEY = os.getenv("GOOGLE_API_KEY")
if not GOOGLE_API_KEY:
    raise EnvironmentError("請設置 GOOGLE_API_KEY 環境變數")
genai.configure(api_key=GOOGLE_API_KEY)

def generate_gemini_reply(content: str) -> str:
    try:
        # 使用最新的、正式支援的模型
        model = genai.GenerativeModel("models/gemini-1.5-pro-latest")
        response = model.generate_content(content)

        if hasattr(response, "text") and response.text:
            return response.text
        else:
            return "AI 回覆失敗，請稍後再試。"
    except Exception as e:
        return f"AI 回覆失敗: {str(e)}"
