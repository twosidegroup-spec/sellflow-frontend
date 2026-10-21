# Cleanup Script - Removes Vercel, Netlify, Render specific files
Write-Host "========================================" -ForegroundColor Red
Write-Host "  CLEANING UP OLD PROVIDERS" -ForegroundColor Red
Write-Host "========================================" -ForegroundColor Red

$files = @(
    "sellflow_app/vercel.json",
    "sellflow_app/vercel-build.sh",
    "sellflow_app/vercel-setup.ps1",
    "sellflow_app/vercel-setup.sh",
    "sellflow_app/netlify.toml",
    "backend/render.yaml"
)

foreach ($f in $files) {
    if (Test-Path $f) {
        Write-Host "  Removing: $f" -ForegroundColor Yellow
        Remove-Item $f
    } else {
        Write-Host "  (Not Found) $f" -ForegroundColor Gray
    }
}

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "  CLEANUP COMPLETE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
