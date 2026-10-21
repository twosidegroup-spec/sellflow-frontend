Set-Location "C:\Users\Sajidul Haque Sajid\Desktop\SELLFLOW\sellflow_app"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Build & Deploy Frontend" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`n[1/3] Building Flutter Web App..." -ForegroundColor Yellow
flutter build web --release --dart-define=RENDER_API_URL=https://sellflow-backend-0nyn.onrender.com/api/v1

if ($LASTEXITCODE -ne 0) {
    Write-Host "  X Build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "  Build completed" -ForegroundColor Green

Write-Host "`n[2/3] Verifying build output..." -ForegroundColor Yellow
if (Test-Path "build\web\index.html") {
    Write-Host "  build/web folder created" -ForegroundColor Green
} else {
    Write-Host "  X build/web folder missing!" -ForegroundColor Red
    exit 1
}

Write-Host "`n[3/3] Zipping build folder..." -ForegroundColor Yellow
Remove-Item "frontend.zip" -ErrorAction SilentlyContinue
Compress-Archive -Path "build\web\*" -DestinationPath "frontend.zip" -Force

if (Test-Path "frontend.zip") {
    Write-Host "  frontend.zip created" -ForegroundColor Green
} else {
    Write-Host "  X Failed to create zip!" -ForegroundColor Red
    exit 1
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Ready for Deployment!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`n  Now go to Netlify and drag frontend.zip into Deploys." -ForegroundColor White
Write-Host "`n  IMPORTANT: Fix CORS on Render first!" -ForegroundColor Yellow
Write-Host "`n  1. Go to: https://dashboard.render.com" -ForegroundColor White
Write-Host "  2. Click your backend service (sellflow-backend)" -ForegroundColor White
Write-Host "  3. Go to Environment tab" -ForegroundColor White
Write-Host "  4. Add/Edit CORS_ORIGINS with this value:" -ForegroundColor White
Write-Host "     https://sellflow-sf.netlify.app,https://localhost:3000" -ForegroundColor Cyan
