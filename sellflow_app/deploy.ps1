# Automated Deploy Script for Flutter Web
# Run this from sellflow_app directory

# Set ErrorActionPreference to stop on errors
$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Deploying to Vercel" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Step 1: Build Flutter
Write-Host "`n[1/3] Building Flutter Web App..." -ForegroundColor Yellow
try {
    flutter build web --release
    Write-Host "  ✓ Build successful" -ForegroundColor Green
} catch {
    Write-Host "  ✗ Build failed" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}

# Step 2: Navigate to build/web and Deploy
Write-Host "`n[2/3] Deploying to Vercel..." -ForegroundColor Yellow

$originalPath = Get-Location
try {
    Set-Location "build/web"
    
    # Deploy to new project or existing linked project
    vercel --prod
    Write-Host "  ✓ Deployment successful" -ForegroundColor Green
} catch {
    Write-Host "  ✗ Deployment failed" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Set-Location $originalPath
    exit 1
} finally {
    Set-Location $originalPath
}

Write-Host "`n[3/3] Deployment Complete!" -ForegroundColor Green
Write-Host "`n📍 Check your deployment at:" -ForegroundColor White
Write-Host "  https://vercel.com/tsg-bfe6" -ForegroundColor Cyan
