# Get Vercel Credentials
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Vercel Setup Guide" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`nStep 1: Login to Vercel" -ForegroundColor Yellow
Write-Host "  Run: vercel login`n" -ForegroundColor White

Write-Host "Step 2: Get Your Project Info" -ForegroundColor Yellow
Write-Host "  Run: vercel ls`n" -ForegroundColor White

Write-Host "Step 3: Get Your Org ID" -ForegroundColor Yellow
Write-Host "  Run: vercel ls --json`n" -ForegroundColor White

Write-Host "Step 4: Get Vercel Token" -ForegroundColor Yellow
Write-Host "  Visit: https://vercel.com/account/tokens`n" -ForegroundColor White

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Store These Secrets in GitHub" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`nGitHub Secrets Location:" -ForegroundColor Yellow
Write-Host "  https://github.com/USERNAME/REPO/settings/secrets/actions`n" -ForegroundColor White

Write-Host "Required Secrets:" -ForegroundColor White
Write-Host "  VERCEL_TOKEN        - Your Vercel API token" -ForegroundColor Gray
Write-Host "  VERCEL_ORG_ID     - Your organization ID" -ForegroundColor Gray
Write-Host "  VERCEL_PROJECT_ID - The project ID" -ForegroundColor Gray
Write-Host "  RENDER_API_URL    - https://sellflow-backend-0nyn.onrender.com/api/v1`n" -ForegroundColor Gray

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  After Adding Secrets" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`n  Then push to main:" -ForegroundColor Yellow
Write-Host "  git add ." -ForegroundColor White
Write-Host "  git commit -m "Deploy flutter frontend"" -ForegroundColor White
Write-Host "  git push origin main`n" -ForegroundColor White

Write-Host "GitHub Actions will automatically deploy to Vercel!" -ForegroundColor Green
