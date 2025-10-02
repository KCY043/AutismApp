from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime
from sqlalchemy.orm import declarative_base
from datetime import datetime

Base = declarative_base()

class Users(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50))
    email = Column(String(100))
    password_hash = Column(String(255))
    role = Column(String(20))
    created_at = Column(DateTime, default=datetime.utcnow)

class ChatLog(Base):
    __tablename__ = "chat_logs"
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer)
    message = Column(Text)
    sender = Column(String(10))
    sentiment = Column(String(20))

class LearningRecord(Base):
    __tablename__ = 'learning_record'
    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, nullable=False)
    task_id = Column(Integer, nullable=False)
    status = Column(Boolean, nullable=False)
    completed_ = Column(DateTime)

class Module(Base):
    __tablename__ = 'module'
    id = Column(Integer, primary_key=True, autoincrement=True)
    title = Column(String(100))
    description = Column(Text)
    image_url = Column(String(255))

class Task(Base):
    __tablename__ = 'task'
    id = Column(Integer, primary_key=True, autoincrement=True)
    # 如果有其他欄位，請補上
