# SellFlow Frontend (Deprecated)

This folder has been removed as part of the backend-first refactoring.

The Flutter mobile application was removed to transform SellFlow into a clean, backend-first SaaS platform.

## What's Next

If you are building a Flutter mobile application for SellFlow:

1. **API Documentation**: See the root `README.md` for API endpoints
2. **Base URL**: `http://localhost:8000/api/v1` (adjust for your environment)
3. **Authentication**: Use JWT tokens from `/api/v1/auth/login`
4. **OpenAPI/Swagger**: Available at `http://localhost:8000/docs`

## Backend Endpoints

| Module | Endpoints |
|--------|-----------|
| Authentication | POST /auth/register, POST /auth/login, GET /auth/me |
| Products | GET/POST/PUT/DELETE /businesses/{id}/products |
| Orders | GET/POST/PATCH /businesses/{id}/orders |
| Payments | GET/POST /businesses/{id}/payments |
| Customers | GET/POST /businesses/{id}/customers |
| Deliveries | GET/POST /businesses/{id}/deliveries |
| Analytics | GET /businesses/{id}/analytics/summary |

For detailed API documentation, consult the backend `README.md` or visit the API docs at `/docs` when the server is running.
