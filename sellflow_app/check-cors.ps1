# CORS Check Script
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Check Render CORS Settings" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`n Your backend URL: https://sellflow-backend-0nyn.onrender.com" -ForegroundColor White
Write-Host "`n Check these settings on Render:" -ForegroundColor Yellow

Write-Host "`n 1. Go to: https://dashboard.render.com" -ForegroundColor White
Write-Host " 2. Click: sellflow-backend" -ForegroundColor White
Write-Host " 3. Click: Environment tab" -ForegroundColor White
Write-Host "`n  Verify CORS_ORIGINS contains:" -ForegroundColor Yellow
Write-Host "  https://sellflow-sf.netlify.app,https://localhost:3000" -ForegroundColor Cyan

Write-Host "`n  After verifying, restart the service:" -ForegroundColor Yellow
Write-Host "  Click: Actions → Restart service" -ForegroundColor Cyan

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Check CORS Response" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`n Test CORS with curl:" -ForegroundColor Yellow
Write-Host "  curl -X OPTIONS -H 'Origin: https://sellflow-sf.netlify.app' https://sellflow-backend-0nyn.onrender.com/api/v1/auth/register" -ForegroundColor White
