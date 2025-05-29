import google.generativeai as genai

#Gemini API 金鑰
genai.configure(api_key="AIzaSyBi0YRSW04rOMkYt9TevBgwQf6_gN0Kh5s")

def generate_ai_reply(user_input):
    try:
        model = genai.GenerativeModel('gemini-pro')
        response = model.generate_content(user_input)
        return response.text
    except Exception as e:
        return "AI 回覆失敗，請稍後再試。"