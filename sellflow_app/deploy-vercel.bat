@echo off
echo ========================================
echo   Vercel Frontend Deployment
echo ========================================
echo.
echo Step 1: Build Flutter Web
echo.
flutter build web --release
if %errorlevel% neq 0 (
    echo Build failed!
    exit /b 1
)
echo.
echo Step 2: Deploy to Vercel
echo.
vercel --name sellflow-sf --prod
echo.
echo ========================================
echo   Deployment complete!
echo ========================================
