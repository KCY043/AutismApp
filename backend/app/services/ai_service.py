import requests

def analyze_sentiment(content: str) -> str:
    try:
        response = requests.post(
            "http://autism_ai_model:8001/analyze-sentiment",
            json={"text": content}
        )
        if response.status_code == 200:
            return response.json().get("label", "NEUTRAL")
        return "NEUTRAL"
    except Exception:
        return "NEUTRAL"