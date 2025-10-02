from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

router = APIRouter()


class User(BaseModel):
    id: int
    name: str


fake_users_db = [
    {"id": 1, "name": "Alice"},
    {"id": 2, "name": "Bob"},
]


@router.get("/users")
def get_users():
    return {"users": fake_users_db}


@router.get("/users/{user_id}")
def get_user(user_id: int):
    user = next((user for user in fake_users_db if user["id"] == user_id), None)
    if user:
        return user
    else:
        raise HTTPException(status_code=404, detail="User not found")

@router.post("/users")
def create_user(user: User):
    fake_users_db.append(user.dict())
    return {"message": "User added successfully", "user": user}