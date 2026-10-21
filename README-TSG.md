# TSG Self-Hosting Infrastructure

This is the official self-hosted deployment for SellFlow. All services run on your own VPS with Docker Compose.

## Architecture

```
┌─────────────────────────────────────────────────┐
│                   TSG VPS                       │
│                                                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────┐ │
│  │ TSG-WEB     │  │ TSG-BACKEND │  │ TSG-DB  │ │
│  │ (Nginx/80) │─▶│ (FastAPI:8000) │─▶│ (Postgres)│ │
│  └─────────────┘  └─────────────┘  └─────────┘ │
│                                                 │
│  Ports: 80 (HTTP), 443 (HTTPS), 8000 (API)      │
└─────────────────────────────────────────────────┘
```

## Quick Start

### Local Development

```bash
# 1. Copy environment template
cp .env.template .env

# 2. Edit .env with your settings
nano .env

# 3. Build frontend
cd sellflow_app
flutter build web --release
flutter build web --release --dart-define=TSG_API_URL=http://localhost:8000/api/v1

# 4. Run all services
cd ..
docker-compose up -d --build

# 5. Initialize database
docker-compose exec tsg-backend alembic upgrade head

# 6. Access
# Frontend: http://localhost:80
# Backend:  http://localhost:8000
```

### VPS Deployment

```bash
# 1. SSH into server
ssh root@your-server-ip

# 2. Run setup script
curl -o tsg-setup.sh https://raw.githubusercontent.com/twosidegroup-spec/sellflow/tsg/tsg-setup.sh
chmod +x tsg-setup.sh
./tsg-setup.sh

# 3. Upload code
scp -r . root@your-server:/opt/tsg/

# 4. Edit environment
cd /opt/tsg
nano .env

# 5. Deploy
docker-compose up -d --build
docker-compose exec tsg-backend alembic upgrade head
```

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `TSG_DB_USER` | Database username | `sellflow_user` |
| `TSG_DB_PASSWORD` | Database password | (required) |
| `TSG_DB_NAME` | Database name | `sellflow_db` |
| `TSG_SECRET_KEY` | Backend secret key | (required) |
| `TSG_APP_ENV` | App environment | `production` |
| `TSG_API_URL` | Frontend API URL | `http://localhost:8000` |

## Security Checklist

- [ ] Change all passwords in `.env`
- [ ] Configure firewall (UFW)
- [ ] Set up SSL with Let's Encrypt
- [ ] Regular backups
- [ ] Keep Docker updated

## Maintenance

### Update
```bash
docker-compose pull
docker-compose up -d --build
```

### View Logs
```bash
docker-compose logs -f
```

### Backup Database
```bash
docker-compose exec tsg-db pg_dump -U $TSG_DB_USER $TSG_DB_NAME > backup.sql
```

## URLs

| Service | URL |
|---------|-----|
| Frontend | `http://your-server-ip` |
| Backend API | `http://your-server-ip:8000` |
| Health Check | `http://your-server-ip:8000/health` |

## Support

Issues: https://github.com/twosidegroup-spec/sellflow/issues
