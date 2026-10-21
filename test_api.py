import sys
import json

try:
    response = requests.post(
        "https://sellflow-backend-0nyn.onrender.com/api/v1/auth/register",
        json={
            "email": "test2@test.com",
            "full_name": "Test User",
            "phone": "",
            "business_name": "Test Business",
            "password": "1234"
        }
    )
    print(f"Status Code: {response.status_code}")
    print(f"Response: {response.text}")
except Exception as e:
    print(f"Error: {type(e).__name__}: {e}")
