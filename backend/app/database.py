

# 假資料（前端測試用，後續可自行增刪）
_fake_users = [
    {"id": 1, "name": "Aaron", "email": "aaron@example.com", "role": "admin"},
    {"id": 2, "name": "Test User", "email": "test@example.com", "role": "user"},
]
_fake_chat_logs = []


class FakeSession:

    # Users
    def list_users(self):
        return list(_fake_users)

    def add_user(self, user):
        new_id = max([u["id"] for u in _fake_users] + [0]) + 1
        user["id"] = new_id
        _fake_users.append(user)
        return user

    # Chat Logs
    def list_chat_logs(self):
        return list(_fake_chat_logs)

    def add_chat_log(self, log):
        new_id = max([c["id"] for c in _fake_chat_logs] + [0]) + 1
        log["id"] = new_id
        _fake_chat_logs.append(log)
        return log


def get_db_session():
    return FakeSession()
