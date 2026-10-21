# ============================================
# TSG FULL DEPLOYMENT SCRIPT
# ============================================

Set-Location "C:\Users\Sajidul Haque Sajid\Desktop\SELLFLOW"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  TSG FULL DEPLOYMENT" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Check Environment
Write-Host "`n[1/4] Checking environment..." -ForegroundColor Yellow
if (-not (Test-Path ".env")) {
    Write-Host "  WARNING: .env file missing" -ForegroundColor Yellow
    Write-Host "  Create: Copy-Item .env.template .env" -ForegroundColor White
    Write-Host "  Edit: Change passwords in .env" -ForegroundColor White
} else {
    Write-Host "  ✓ .env file found" -ForegroundColor Green
}

# Check Backend
Write-Host "`n[2/4] Checking backend..." -ForegroundColor Yellow
if (Test-Path "backend") {
    Write-Host "  ✓ Backend folder found" -ForegroundColor Green
} else {
    Write-Host "  ✗ Backend folder missing" -ForegroundColor Red
    exit 1
}

# Build Frontend
Write-Host "`n[3/4] Building frontend..." -ForegroundColor Yellow
Set-Location "sellflow_app"
flutter build web --release --dart-define=TSG_API_URL=http://localhost:8000/api/v1
Set-Location ".."

Write-Host "  ✓ Frontend built" -ForegroundColor Green

# Check Docker
Write-Host "`n[4/4] Checking Docker..." -ForegroundColor Yellow
if (Test-Path "docker-compose.yml") {
    Write-Host "  ✓ Docker Compose found" -ForegroundColor Green
    Write-Host "`n  Services:" -ForegroundColor White
    Write-Host "  - TSG-WEB" -ForegroundColor Gray
    Write-Host "  - TSG-BACKEND" -ForegroundColor Gray
    Write-Host "  - TSG-DB" -ForegroundColor Gray
} else {
    Write-Host "  ✗ docker-compose.yml missing" -ForegroundColor Red
    exit 1
}

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "  ✅ DEPLOYMENT READY" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

Write-Host "`n  START SERVICES: docker-compose up -d" -ForegroundColor Cyan
Write-Host "  INIT DB:      docker-compose exec tsg-backend alembic upgrade head" -ForegroundColor Cyan
Write-Host "`n  ACCESS:" -ForegroundColor White
Write-Host "  Frontend: http://localhost" -ForegroundColor White
Write-Host "  Backend:  http://localhost:8000" -ForegroundColor White
