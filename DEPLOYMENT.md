# Deploying SellFlow

## Architecture
- **Frontend**: Flutter Web (Vercel)
- **Backend**: FastAPI (Render)

---

## Frontend Deployment (Vercel)

### 1. Update Environment Variable
Set your Render backend URL:
```
RENDER_API_URL=https://sellflow-backend-0nyn.onrender.com/api/v1
```

### 2. Deploy via CLI
```bash
cd sellflow_app
flutter build web --release --dart-define=RENDER_API_URL=https://sellflow-backend-0nyn.onrender.com/api/v1
vercel --prod
```

### 3. Deploy via GitHub (Recommended)
1. Push code to GitHub
2. Connect to Vercel
3. Vercel will automatically build and deploy

---

## Backend Deployment (Render)

### 1. Create Web Service
- Connect GitHub repository
- Root directory: `backend`
- Build command: `chmod +x build.sh && ./build.sh`
- Start command: `uvicorn app.main:app --host 0.0.0.0 --port $PORT`

### 2. Environment Variables
```
SECRET_KEY=your-secret-key-here
DATABASE_URL=postgresql://user:pass@host:5432/db
APP_ENV=production
APP_DEBUG=false
PORT=8000
HOST=0.0.0.0
CORS_ORIGINS=https://sellflow.vercel.app,https://localhost:3000,https://sellflow-backend-0nyn.onrender.com
```

---

## Testing After Deploy

1. Check backend health: `https://sellflow-backend-0nyn.onrender.com/health`
2. Open frontend: `https://sellflow.vercel.app`
3. Try login/signup flow

---

## Local Development

```bash
# Backend
cd backend
uvicorn app.main:app --reload

# Frontend
cd sellflow_app
flutter run -d chrome
```
