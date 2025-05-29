FROM python:3.10

WORKDIR /app
COPY ./backend /app/backend
RUN pip install -r /app/backend/requirements.txt
CMD ["uvicorn", "backend.main:app", "--host", "0.0.0.0", "--port", "8000"]