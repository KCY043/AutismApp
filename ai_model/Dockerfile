FROM python:3.10-slim

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt


CMD ["uvicorn", "ai_model_entry:app", "--host", "0.0.0.0", "--port", "8001"]