from transformers import pipeline
sentiment_pipeline = pipeline("sentiment-analysis")

def analyze_sentiment(text: str) -> str:
    try:
        result = sentiment_pipeline(text)[0]
        return result['label'].upper()
    except:
        return "NEUTRAL"