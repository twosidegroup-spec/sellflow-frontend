# CORS Fix Checklist
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  CORS Fix Checklist" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`n STEP 1: Check Render Environment Variables" -ForegroundColor Yellow
Write-Host "1. Go to: https://dashboard.render.com" -ForegroundColor White
Write-Host "2. Click: sellflow-backend" -ForegroundColor White
Write-Host "3. Click: Environment tab" -ForegroundColor White
Write-Host "`n4. Check for: CORS_ORIGINS" -ForegroundColor Cyan
Write-Host "   Value should be: https://sellflow-sf.netlify.app,https://localhost:3000" -ForegroundColor Cyan
Write-Host "`n5. If NOT EXISTS, add it:" -ForegroundColor Yellow
Write-Host "   Key: CORS_ORIGINS" -ForegroundColor White
Write-Host "   Value: https://sellflow-sf.netlify.app,https://localhost:3000" -ForegroundColor White

Write-Host "`n STEP 2: Restart Backend" -ForegroundColor Yellow
Write-Host "1. Click: Actions → Restart service" -ForegroundColor White
Write-Host "2. Wait 2 minutes for restart" -ForegroundColor White

Write-Host "`n STEP 3: Test CORS" -ForegroundColor Yellow
Write-Host "1. Open browser console (F12)" -ForegroundColor White
Write-Host "2. Go to Network tab" -ForegroundColor White
Write-Host "3. Try to register" -ForegroundColor White
Write-Host "`n   You should see:" -ForegroundColor Cyan
Write-Host "   - OPTIONS request: 200 OK" -ForegroundColor Green
Write-Host "   - POST request: 201 Created" -ForegroundColor Green

Write-Host "`n STEP 4: If Still Fails" -ForegroundColor Yellow
Write-Host "1. Check Render Logs for CORS errors" -ForegroundColor White
Write-Host "2. Check if backend is using settings.cors_origins" -ForegroundColor White
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  After CORS is fixed, redeploy frontend:" -ForegroundColor Cyan
Write-Host "  .\rebuild-and-deploy.ps1" -ForegroundColor White
Write-Host "`n========================================" -ForegroundColor Cyan
