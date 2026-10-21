# SellFlow Backend

## API-First SaaS Platform

SellFlow is a backend-first, production-oriented SaaS platform for social commerce and seller operations. The backend exposes a well-documented REST API designed for consumption by mobile applications (e.g., Flutter) or web frontends.

## Architecture

| Component | Technology |
|-----------|------------|
| Framework | FastAPI (Python 3.11) |
| Database | PostgreSQL |
| ORM | SQLAlchemy 2.0 |
| Migrations | Alembic |
| Auth | JWT (python-jose) |
| Password Hashing | bcrypt |

## Quick Start

### Prerequisites

- Python 3.11+
- PostgreSQL 14+
- Docker (optional, for local database)

### Installation

```bash
# Clone repository
git clone <repository-url>
cd backend

# Create virtual environment
python -m venv .venv
.venv\Scripts\activate  # Windows
source .venv/bin/activate  # macOS/Linux

# Install dependencies
pip install -r requirements.txt
```

### Environment Setup

```bash
# Copy environment template
cp .env.example .env

# Edit .env with your values:
DATABASE_URL=postgresql://user:password@localhost:5432/sellflow
SECRET_KEY=your-secret-key-here
JWT_ALGORITHM=HS256
JWT_EXPIRE_MINUTES=60
```

### Database Setup

```bash
# Run migrations
alembic upgrade head

# (Optional) Seed test data
python scripts/seed.py
```

### Running the Server

```bash
# Development
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

# Production (using gunicorn)
gunicorn app.main:app -w 4 -k uvicorn.workers.UvicornWorker
```

Access API docs at: http://localhost:8000/docs

## API Endpoints

### Authentication (`/api/v1/auth`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/v1/auth/register` | Register new user with optional business |
| POST | `/api/v1/auth/login` | Login with email and password |
| GET | `/api/v1/auth/me` | Get current user (requires auth) |

### Businesses (`/api/v1/businesses`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/businesses/` | List businesses |
| GET | `/api/v1/businesses/{id}` | Get business details |

### Products (`/api/v1/businesses/{business_id}/products`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/businesses/{business_id}/products` | List products |
| POST | `/api/v1/businesses/{business_id}/products` | Create product |
| GET | `/api/v1/businesses/{business_id}/products/{id}` | Get product |
| PUT | `/api/v1/businesses/{business_id}/products/{id}` | Update product |
| DELETE | `/api/v1/businesses/{business_id}/products/{id}` | Delete product |

### Customers (`/api/v1/businesses/{business_id}/customers`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/businesses/{business_id}/customers` | List customers |
| POST | `/api/v1/businesses/{business_id}/customers` | Create customer |

### Orders (`/api/v1/businesses/{business_id}/orders`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/businesses/{business_id}/orders` | List orders |
| POST | `/api/v1/businesses/{business_id}/orders` | Create order |
| GET | `/api/v1/businesses/{business_id}/orders/{id}` | Get order |
| PATCH | `/api/v1/businesses/{business_id}/orders/{id}/status` | Update order status |

### Payments (`/api/v1/businesses/{business_id}/payments`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/businesses/{business_id}/payments` | List payments |
| POST | `/api/v1/businesses/{business_id}/payments` | Record payment |

### Deliveries (`/api/v1/businesses/{business_id}/deliveries`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/businesses/{business_id}/deliveries` | List deliveries |
| POST | `/api/v1/businesses/{business_id}/deliveries` | Create delivery |

### Analytics (`/api/v1/businesses/{business_id}/analytics`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/businesses/{business_id}/analytics/summary` | Get dashboard summary |

### Health (`/health`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/health` | Health check |

## Authentication

All protected endpoints require a JWT token in the Authorization header:

```
Authorization: Bearer <access_token>
```

## Multi-Tenancy

All business-scoped endpoints enforce tenant isolation. Users can only access data from businesses they belong to.

## Testing

```bash
# Run all tests
pytest

# Run specific test file
pytest tests/test_auth.py -v
```

## Security Features

- JWT-based authentication
- Rate limiting (configurable)
- CORS protection
- Password hashing with bcrypt
- Tenant isolation

## Deployment

See [backend/DEPLOYMENT.md](backend/DEPLOYMENT.md) for production deployment instructions.

## License

Proprietary
