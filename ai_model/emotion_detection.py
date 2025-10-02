def detect_emotion(text):
    emotions = ["happy", "sad", "angry", "neutral"]
    return "neutral" if not text else emotions[hash(text) % len(emotions)]